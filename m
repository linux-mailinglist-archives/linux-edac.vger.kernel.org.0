Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE523E3638
	for <lists+linux-edac@lfdr.de>; Sat,  7 Aug 2021 18:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhHGQAw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 7 Aug 2021 12:00:52 -0400
Received: from mout.gmx.net ([212.227.15.18]:42673 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230332AbhHGQAu (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 7 Aug 2021 12:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628352012;
        bh=2ti2yxVR7eGU9gsi3/G84Kbo5FGNC3s1wKPVeeD9hR4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=WKuTI4cpaUXrlSiKZUQCvTksGS9NSb6T2n/3B/l4D/+p4t0X62Lv5MaCJHHcWYF0H
         IcSvrXEvI5P/7QOOFFnEj5veUIOZfUzl0O7zO5fP+eGJex9henjoqTjP2y/ZgFoRMR
         SEZwjshHrKXimekV4h6Vm/EEp8KNAjYuYpvASltg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MZCb5-1mhWYs32AL-00VA1H; Sat, 07 Aug 2021 18:00:11 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] drivers/edac/edac_mc: Remove all strcpy() uses
Date:   Sat,  7 Aug 2021 17:59:57 +0200
Message-Id: <20210807155957.10069-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vPhsX4qcrwNVuGiLz6ovSR1AIIzaIr5pTe5P5tLUSytoH1sDb+f
 HGw0nc6yYSQMsX9gei/2Aax1cN6bC/lAJvdJy2kLsQFkkqRDz960w+JyzD5QSGHS7n0jBZR
 4LzqBeetm6kDtJGNIlwyO6soSBtkYsd0nRLIdR21Wi3TurtZFmWurLai82u5wTm20nuk7ID
 vG294ocgQmLZfK1+tb8nQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:h7M3H6W0ww8=:HCsiqgamO4sSLT3l4nO3Hg
 zmqGIXBHgHJZfwHnJql7KqnJfqTiTLwPdPLmjEkIkc2em9YGOpqAXhW31zGvjJqHRZYXxm4Qc
 pgj4gUUIViEgxRntbHAv1wHaNfvMHVIRAKUtkLqGvVBpZ3XH5juD3ax86x8AHk0dJVyUgjOA3
 uT+agLv/ejjv6bSpFZvX3vzjTSrLWB7EBAZ8Xnw1TZec8dCibb6ZyV+Ko/4QNwScvCDqx3KVe
 xsN39EVjJokM43++YsIpeVXsA6LSSaB2ucWlPXSUaYiRXdJUGRjppGUuV8TUrvnsNHplhIHs5
 F8HojC6SoXDlXKIUpcUXeVsBFBEG214szSaReRy4K5/PVf6cLav5Ps/oL1ZoUdcuwpPfZhvNG
 BNZvNPzNks/mzLm5Rjh1mR+c8JMpJopS1agcMMhcnwf5tsUSofbM1vVQbXwZyX/opcg8NKzru
 t2v7jZY25Nu3thh84HicEYBCVABjERcfOcjf6dr1q+aDo+2HCiHOIwA6zUiVHb+kwqUFq1LO8
 ZGglcnugkrHbxMjvYRd3yhcEsmR8FeK4P8DT3AkbA4DZDD/vdCfn8TvzsgiI9RCUZ5tLRyi7L
 gu4NwXwpm9Q4mcQv5qSo1+CXFg2/OtK4CxyCAYdDJ5lSv435i1ToaKyLcvOwWZn1RGHZlJKaS
 NF0VnCEZW71j+WQ2kLrNoL2yCR4mPehTMdgjEhV92sj38MWG3Jmym+0X9Xz+4DVbaSCnpFtgC
 0FwETzBbVUSp+g1x+1ETEcbtpPGfYsdDMkJAw65/twSVQ7rW0i7Z2mT1ccn1vdlCVxnhAK2EK
 rxq6YPNPioupTWykgJ1PHl0gTA3qnhOgYhCXS+XQDnA+BJyJTlBeaMWYSq5f7SbL6NctSt2ev
 Pv1l/oY/XISgXJovVeRYlMeDwAGcMXoyhtAMfk+D/tZ/8PtUzeCIdtvqIKhECXU8tXmnEE8FH
 q4AD5jJcztiftxUd84HCogK7NAMj5gn1cD54pYAQQ+gna+zM33E0EX9CwANRqc0ii/KuLtn/G
 cCHY2mc7Ill5PoS0Qjrq2KDQ/wQsNwlwm6/RzBUJp/kR1S4W4C2KGGcisVlAWQ4400Sg71goK
 UEXhB/3RDOm90ekoJngZfGin155tldQba+ajtSr8mAMi3NXVrLD+dT3VA==
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

Changelog v2 -> v3
- Rename the "left" variable to "len" (Robert Richter).
- Use strlen(p) instead of strlen(OTHER_LABEL) to decrement "len" and
  increment "p" as otherwise "left" could underflow and p overflow
  (Robert Richter).

Previous versions:

v1
https://lore.kernel.org/linux-hardening/20210725162954.9861-1-len.baker@gm=
x.com/

v2
https://lore.kernel.org/linux-hardening/20210801143558.12674-1-len.baker@g=
mx.com/

 drivers/edac/edac_mc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index f6d462d0be2d..0cdb1e9320ba 100644
=2D-- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1032,6 +1032,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err=
_type type,
 	int i, n_labels =3D 0;
 	struct edac_raw_error_desc *e =3D &mci->error_desc;
 	bool any_memory =3D true;
+	size_t len;

 	edac_dbg(3, "MC%d\n", mci->mc_idx);

@@ -1086,6 +1087,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err=
_type type,
 	 */
 	p =3D e->label;
 	*p =3D '\0';
+	len =3D sizeof(e->label);

 	mci_for_each_dimm(mci, dimm) {
 		if (top_layer >=3D 0 && top_layer !=3D dimm->location[0])
@@ -1113,11 +1115,11 @@ void edac_mc_handle_error(const enum hw_event_mc_e=
rr_type type,
 			p =3D e->label;
 			*p =3D '\0';
 		} else {
-			if (p !=3D e->label) {
-				strcpy(p, OTHER_LABEL);
-				p +=3D strlen(OTHER_LABEL);
-			}
-			strcpy(p, dimm->label);
+			const char *text =3D (p !=3D e->label) ? OTHER_LABEL :
+				dimm->label;
+
+			strscpy(p, text, len);
+			len -=3D strlen(p);
 			p +=3D strlen(p);
 		}

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

