# material_dialog

A new Flutter package.

## Getting Started

| Property          | Type         | Default Value | Description                                                                                                                                       |
|------------------ |--------------|---------------|---------------------------------------------------------------------------------------------------------------------------------------------------|
| title             | Widget       | null          | The (optional) title of the dialog is displayed in a large font at the top of the dialog.                                                         |
| subTitle          | Widget       | null          | The (optional) subtitle of the dialog is displayed below title of the dialog.                                                                     |
| content           | Widget       | null          | The (optional) content of the dialog is displayed in the center of the dialog in a lighter font.                                                  |
| actions           | List<Widget> | null          | The (optional) set of actions that are displayed at the bottom of the dialog.                                                                     |
| children          | List<Widget> | null          | The (optional) content of the dialog is displayed in a [SingleChildScrollView] underneath the title.                                              |
| headerColor       | Color        | null          | The (optional) header color is displayed in the header background.                                                                                |
| backButtonColor   | Color        | Colors.white  | The (optional) back button color. By default its set to white.                                                                                    |
| closeButtonColor  | Color        | Colors.white  | The (optional) close button color. By default its set to white.                                                                                   |
| onBackClick       | VoidCallback | null          | A callback function to get back button event from dialog. If back button is enabled this callback has to be provided in-order to get callbacks.   |
| onCloseClick      | VoidCallback | null          | A callback function to get close button event from dialog. If close button is enabled this callback has to be provided in-order to get callbacks. |
| enableBackButton  | bool         | false         | The (optional) value to enable/disable back button for a dialog.                                                                                  |
| enableCloseButton | bool         | false         | The (optional) value to enable/disable close button for a dialog.                                                                                  |
| enableFullWidth   | bool         | true          | The (optional) value to stretch dialog to its max width.                                                                                          |
| enableFullHeight  | bool         | false         | The (optional) value to stretch dialog to its max height.                                                                                         |
| borderRadius      | double       | 10.0          | The (optional) border radius of a dialog. by default its 10.0.                                                                                    |
