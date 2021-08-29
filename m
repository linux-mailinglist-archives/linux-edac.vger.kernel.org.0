Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF743FAD0D
	for <lists+linux-edac@lfdr.de>; Sun, 29 Aug 2021 18:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbhH2QR0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 29 Aug 2021 12:17:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:39999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231422AbhH2QRZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 29 Aug 2021 12:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630253771;
        bh=QVHyvI9KdhzZcQz94YWSC2j89Kyz4s6qibr9Q6OcfAE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=h7+gWvn/EwWsQR9BzyfsTXwwR9sd0RsBYNX/qM/DpFFRJI0XAdK103KFD8N8/XMy7
         Yn8PWhHDJ2uWFdA8w3rUhQ9QZazPLr/VeUHeMwgpkDALUKey9KGaCCslqwL/5VPKPL
         uH1WoECpn6HazQvUY0/com/dz1pbWupSJ/CsnW+o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MSbx3-1mQkK33xIv-00T0FD; Sun, 29 Aug 2021 18:16:11 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Cc:     Len Baker <len.baker@gmx.com>, Joe Perches <joe@perches.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] EDAC/mc: Prefer strscpy or scnprintf over strcpy
Date:   Sun, 29 Aug 2021 18:15:47 +0200
Message-Id: <20210829161547.6069-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5DOd5SPyXVynGrL5JbOHhRVSwiZMbWyJhivQ6XgY1E9falei9Wu
 Au8xhZoi8Zvn3EfUfefktauECPl9vEkvr9hALYkGsisU0f6lHSY4q24f/h2KN/1FasD/IG5
 DZ4hz/JvBHCzlw/zjFbFBjUPPz1evj0uscN9kUcUYivlJJBbjABvMGLYENFqnQIYwoemUTm
 Npjs8vEzsrPnei5Za9Efw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:T6D9FN3N/Wc=:OQxThfh4CmI+ZBcZaMd3QK
 U7v0rdegaeFedfXVs7dJSXjML4/c1zYeRMw3CZnoWTyhxBObLeXMXX6iWtTEzhRRNI4+EQLx8
 Xy574m/QUxTiknTCmNx4LkAftQmuRr/D2JOJg3iLwMPCurO1QBtNHDt+VQltzXhS4nH4mLqMw
 XtobF12uBoStk0T2oWFdbfeOk5dY3pGe75c9q4OKPKp/JzqgqkoifcCU4ndUlEXca+IAuVANA
 /GRRHuN4AJCq0Dlz33cv8yU8KbJRgj3BGZ3MuQJyHeMSRqjQB6Fji3+2khka9YDtv0iCepE47
 39j7e7Dh30sNv8W0AthXNmY123WIex8Fd/ofq9mfy6A3EgFPDHaBPe5W3xeY1PgfexuvCz9sV
 wY2GM1xR4EQ+3nQQ4ExeAHkTcrRqOR0NVDrmTkoFQOLsGNwKzGSD039G0OfQwqmrf7RQh5uTp
 eHaHXRlBSMGHU2Q3id4FYAfwyB3hak5ubG4dBUqLNw1Fh21a4ZzHoBGrYoTLoYG62FiF/IdDD
 P0RND/LLewNo69cLjmmDegserwCNfUdGMs8lNSesRq0jZ8ZEkI02FLiDEWulVmtWvtn00xd4q
 c3ZUTnkqr+2dgQx76VtDDye7GdV/WIDmJbyfuVi2ydm2gir9vKQLvRzGUg/9u48fcrXnETUtg
 l5uPiDJSyhQtumcq5704gtCJaEWfPKaBEdnjAbzU5aMTMU2BO/5XA4HupyTJWQdiHqNImomub
 0MsVD2645RBoOi9xZ4igUEBcWQ1UGet/YG9Pf93QGzStPW7eeHl/IhUp0cDJN6G0gR4j72G94
 Ov0FpjNwOM5yWRDmfmgnQawSNqHgByW3RgDuJyMsCy0ZynopODmZbLSDRMRPWg9QkmSeenu+l
 U3py6V/vjGGKUniD6M2Xn16sCFQTIoGbKL/2wMdxhB6mUYZ6KvHNetpnT6QouHqOmwTxaZKvC
 T96ZAUQPmSWsj6SITtDjlH+/v1+gT7hL+WM9ZCh9JDYCNO2emFmZWvr5VXFhK/d4lhhNLwUj3
 ZdGbUBJOnO7bjC9XEi1rNEbdycDq6HIgST2oOZiu9IaYSRmSUAwgm/wcTuGk2+zMhN0uTnIXu
 w1eY2blscCZ1I5k3fWVudeqKneQVh4HDAw3dIk2QJL0i4DOoS3Kc36k3g==
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. The safe replacement is strscpy() [1].

However, to simplify and clarify the code, to concatenate labels use
the scnprintf() function. This way it is not necessary to check the
return value of strscpy (-E2BIG if the parameter count is 0 or the src
was truncated) since the scnprintf returns always the number of chars
written into the buffer. This function returns always a nul-terminated
string even if it needs to be truncated.

The main reason behind this patch is to remove all the strcpy() uses
from the kernel with the purpose to clean up the proliferation of
str*cpy() functions. Later on, the next step will be remove all the
strcpy implementations [2].

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy
[2] https://github.com/KSPP/linux/issues/88

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
Hi,

Next try. I hope this version will be accepted. Anyway, thanks for
the reviews and patience ;)

Thanks,
Len

Changelog v1 -> v2
- Use the strscpy() instead of scnprintf() to add labels and follow a
  code pattern more similar to the current one (advance "p" and
  decrement "left") (Robert Richter).

Changelog v2 -> v3
- Rename the "left" variable to "len" (Robert Richter).
- Use strlen(p) instead of strlen(OTHER_LABEL) to decrement "len" and
  increment "p" as otherwise "left" could underflow and p overflow
  (Robert Richter).

Changelog v3 -> v4
- Change the commit subject (Joe Perches).
- Fix broken logic (Robert Richter).
- Rebase against v5.14-rc5.

Changelog v4 -> v5
- Change the commit subject.
- Clarify why the change is being made by adding more info to the
  commit message (Borislav Petkov).
- Use scnprintf instead of strscpy (Joe Perches).
- Rebase against v5.14-rc7.

Previous versions:

v1
https://lore.kernel.org/linux-hardening/20210725162954.9861-1-len.baker@gm=
x.com/

v2
https://lore.kernel.org/linux-hardening/20210801143558.12674-1-len.baker@g=
mx.com/

v3
https://lore.kernel.org/linux-hardening/20210807155957.10069-1-len.baker@g=
mx.com/

v4
https://lore.kernel.org/linux-hardening/20210814075527.5999-1-len.baker@gm=
x.com/

 drivers/edac/edac_mc.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index f6d462d0be2d..4fe1286ad7a2 100644
=2D-- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1032,6 +1032,8 @@ void edac_mc_handle_error(const enum hw_event_mc_err=
_type type,
 	int i, n_labels =3D 0;
 	struct edac_raw_error_desc *e =3D &mci->error_desc;
 	bool any_memory =3D true;
+	size_t len;
+	int n;

 	edac_dbg(3, "MC%d\n", mci->mc_idx);

@@ -1086,6 +1088,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err=
_type type,
 	 */
 	p =3D e->label;
 	*p =3D '\0';
+	len =3D sizeof(e->label);

 	mci_for_each_dimm(mci, dimm) {
 		if (top_layer >=3D 0 && top_layer !=3D dimm->location[0])
@@ -1113,12 +1116,11 @@ void edac_mc_handle_error(const enum hw_event_mc_e=
rr_type type,
 			p =3D e->label;
 			*p =3D '\0';
 		} else {
-			if (p !=3D e->label) {
-				strcpy(p, OTHER_LABEL);
-				p +=3D strlen(OTHER_LABEL);
-			}
-			strcpy(p, dimm->label);
-			p +=3D strlen(p);
+			const char *or =3D (p !=3D e->label) ? OTHER_LABEL : "";
+
+			n =3D scnprintf(p, len, "%s%s", or, dimm->label);
+			len -=3D n;
+			p +=3D n;
 		}

 		/*
@@ -1140,9 +1142,9 @@ void edac_mc_handle_error(const enum hw_event_mc_err=
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

