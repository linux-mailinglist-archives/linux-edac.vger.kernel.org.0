Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D22E3DCC1D
	for <lists+linux-edac@lfdr.de>; Sun,  1 Aug 2021 16:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhHAOgk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 1 Aug 2021 10:36:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:40843 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231791AbhHAOgk (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 1 Aug 2021 10:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627828577;
        bh=VXqJ8QWlpEx1RDMRJ5UNDvGpm6vOyDvjBgb3xy3rciI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=TDsdu7i15oIiHMvOtnbziIoTMVyTfDzk/DGhQ31uScjTfDqHfGW8ep+qf4Z9uqPPA
         Ip3bqkfVZdH0p+skJqN93hpMYEHEdqkUpAcWd4Hrwq1X0pNMSfH1RIcGEyBgps9qkz
         /Vv6mqBp/s6mn+1awqhtzAsAN4VDv2MaGDeA2O+E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MGQnF-1mOjhV3de9-00Grca; Sun, 01 Aug 2021 16:36:17 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Cc:     Len Baker <len.baker@gmx.com>, linux-hardening@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drivers/edac/edac_mc: Remove all strcpy() uses
Date:   Sun,  1 Aug 2021 16:35:58 +0200
Message-Id: <20210801143558.12674-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6rhhofEREEauhZ46iiRDsPO1exN6r792lyPoEBYXJIH25KKvIub
 W2wyBAJ7a4AFdHyNTA+2xHyWOSboVjHKCxfgAQ4HnKDxtuwj4lLiyJ4/NBblN6rMeMlyAHK
 0koorX3tEcsiZmH5pZDRpZje/T8XJvJdkIT7Rx79NiS8m+CF0EPpvQPFU9mGQDCpk3E6q9t
 rGCWKF/ORctMnNvkq9k/Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IdVG9JmztP0=:l5Od/NNE8OUJczdPns7iZN
 t/V8gjsvRVT64XKMjtbuX34lYAMDG2twiTzjLMeXWSZ2GBnTiMyd+cRvIipQksNG8vn5QZPTX
 pG/81fNwhLGnTQtKWfgZ7iD+U/x7C44V2bRUfFyUF3o810GxKwGeUT2M96x39m+af2h+HD29S
 iD1YrAqPx5PRvhU42HX9cKI6316tgmR942WyV2m3YkTCx/uPXd9k+ouQoiraFVzpFJtR7niKa
 qGsZxVHU1wPDSGKqWBSUgPMwfM+ra3HOGSJVH0ZE/Ci11iKQaf2boIgn6K8slJT9MXIMd3Grz
 U0y6caHWB8x9ibRldjwOQD+uF61RcWO/7KZeCBfcHyQGv3poaawDZnpwyuepfdlbNsrgCXMQs
 Nc4nmT83jJDDTttpCW3CKNzVA8x/vxVAMBJZDPFZSsrW+b5bwRYqhaIJsJsfSjUylSdU6Nkga
 MBcCh3K458q4r6ani4H5kElUYY63YDeduClbAL2eG2gx3T3ro/nmG7wHxwR2oZG5V9vCl4MDm
 Y4dJz3CYyrvIWCvB0Emp/v3OhRSYR+F1JQsNCLO38CaNI+bcy2CAMKT6FYTdP57oIhYAUYa7L
 PE9lITdWHDhJ8EylkjXWD8AV1pEB9xWJEFh2e1hjHX5a2Zr3/F6hGE8mvXb7Eghk9lqGG3YKY
 NEq0ivj8qU5HiZY2nN8xxU0jJY2duhj81CD1v6Dzh1nII2sYwxmzgpHnFqQXDwwVgQn1ejf+i
 ysBd0LR1nYwPguNrNKcLnAggIK9aFNnOOn8wFd+konPjNFvhSoGX9adG8/BBVHhUSHZhLmLx8
 Ex4wdoHHi1MstCxuTdefzGQDhfKlSYWkjRzR4D455CgrQwKKmk3H2xqFv1X6l72aF93Jv0j2K
 0HCr0SJRcefKlKgn3JYPGRR/7VV9FjIrS+gYafAKm6KuKVNtlQfcovtyNUxBPA0HNZrXe8n3J
 1fCbfXq12LQDbBHXax710VgMvbAmKlON6vrSczsAnbMs/aGW4yZrgIH+aq4ArCJk9x/Jnc0rq
 Kumzv3Hn95XPFLlN9pRPES4cGNsIqi537tqYq7O7AAnuiZ5DJ1qiqO/KVPMMya2nE2+VpEj/o
 YvMgIh4eZ+CbM5PCweYEmhyjVyecMHqIkA0
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. The safe replacement is strscpy().

This is a previous step in the path to remove the strcpy() function
entirely from the kernel.

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
This is a task of the KSPP [1]

[1] https://github.com/KSPP/linux/issues/88

Changelog v1 -> v2
- Use the strscpy() instead of scnprintf() to add labels and follow a
  code pattern more similar to the current one (advance "p" and
  decrement "left") (Robert Richter).

 drivers/edac/edac_mc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index f6d462d0be2d..13b50be22ba6 100644
=2D-- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1032,6 +1032,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err=
_type type,
 	int i, n_labels =3D 0;
 	struct edac_raw_error_desc *e =3D &mci->error_desc;
 	bool any_memory =3D true;
+	size_t left;

 	edac_dbg(3, "MC%d\n", mci->mc_idx);

@@ -1086,6 +1087,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err=
_type type,
 	 */
 	p =3D e->label;
 	*p =3D '\0';
+	left =3D sizeof(e->label);

 	mci_for_each_dimm(mci, dimm) {
 		if (top_layer >=3D 0 && top_layer !=3D dimm->location[0])
@@ -1114,10 +1116,12 @@ void edac_mc_handle_error(const enum hw_event_mc_e=
rr_type type,
 			*p =3D '\0';
 		} else {
 			if (p !=3D e->label) {
-				strcpy(p, OTHER_LABEL);
+				strscpy(p, OTHER_LABEL, left);
+				left -=3D strlen(OTHER_LABEL);
 				p +=3D strlen(OTHER_LABEL);
 			}
-			strcpy(p, dimm->label);
+			strscpy(p, dimm->label, left);
+			left -=3D strlen(p);
 			p +=3D strlen(p);
 		}

@@ -1140,9 +1144,9 @@ void edac_mc_handle_error(const enum hw_event_mc_err=
_type type,
 	}

 	if (any_memory)
-		strcpy(e->label, "any memory");
+		strscpy(e->label, "any memory", sizeof(e->label));
 	else if (!*e->label)
-		strcpy(e->label, "unknown memory");
+		strscpy(e->label, "unknown memory", sizeof(e->label));

 	edac_inc_csrow(e, row, chan);

=2D-
2.25.1

