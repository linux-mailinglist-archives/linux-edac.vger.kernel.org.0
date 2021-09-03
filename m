Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B5B4001AE
	for <lists+linux-edac@lfdr.de>; Fri,  3 Sep 2021 17:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbhICPHN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Sep 2021 11:07:13 -0400
Received: from mout.gmx.net ([212.227.17.21]:43751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229997AbhICPHM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 3 Sep 2021 11:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630681561;
        bh=2NsobSJ0oyoOkDCO4kNPox42OsO4Nli7GYVADpwZFfk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=KgB1oGa26/ftR5JtjgnCkm+LjSNjE91aGRPWcIb6t1XB5VbxTe/0HHCk1dylY+IhD
         8DHPkRcgqvDIVMlzTPzOliBWGvdT5qyWcy6PpE8paNeNscd2vLNj9LcWiYGNVdiEcb
         ypTdR3d8h/HQ+TSjwVDIsvtLo0TcbPChzCm4JtPA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1M1Ycl-1mO5di2BWl-0038Dr; Fri, 03 Sep 2021 17:06:01 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, Joe Perches <joe@perches.com>
Cc:     Len Baker <len.baker@gmx.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6] EDAC/mc: Prefer strscpy or scnprintf over strcpy
Date:   Fri,  3 Sep 2021 17:05:39 +0200
Message-Id: <20210903150539.7282-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1WWrz35yiVKX3AEpwLelo43wNkwyWS28+jV7tcAjnkGOVJRGex4
 62kMobnU+zTr4NUJU2ElQKZSbknVD9xi/fiZzgHOPEn0yel6FeiNrZ0/rYf7Tqr15wECqqe
 saJNo9jDiqMX7ZTjwu2Gk76XKK9yCFifqrNUd7hHgSBKW/shQPYUUZhnwVeDiho6+DlLcTJ
 4lx+zPpb5BPdw91l7pDug==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:IZ8oGDh5x9g=:U+bLOJMA3OId4qv5emQuZJ
 U3SDolIicL6kmud82MC2AcCCKEKfgtK6iwlCcbXPpLe8oRZG32aFPhUPF4i6+81O3fuWjqaYv
 AfCueHqlctbkBfoxJvZl4GFMHIczszAa6hzwS03rHmJzbOY7FU2CozUGVofdPegbWbPeZkrKl
 W2ZNOhpTEvj6nerJFSl7FkalWzKab6bgvItqGNZesS55bBax9SWf3yZiHGh++skpxzY9Yv71g
 87OtKy3xdcTECktspsLeGVBeompS816qCi6TOeTYrLyeVsDdt4KEqkfFNrdVx7IXdwg16TGsa
 yGZCDzHtCaWTendBhow9Un3qUENtZboG9rQLXPnboFGBMoaFsnkgRM6i6vi8lgPlxQEpmsuyR
 nqo1h5k+lraAbmF1UuPV4I15e4yr61npqDc29+Fy4LMNt5cV1FHhWigLSc4vurAFcMTfNVcWc
 jA1uH9avsfU9hGU78MPK0vGSawZEkPxtBzUqzSCeFUCTjq5njHGT0xqrSWJ2hKtyiT4tObcEn
 4NkuPxFPaiyYOgYah0WCYUCY0SM4MhK1u3SYRCincR313ICEX50GUyesA0Fdy+i+7audYHyXr
 geDDSsqHNNanXAB/0Tjz754Gm7qIXKhBigPCBY2rrLBPpXH8LGgfeQt2znXbXNB19K4oqaovA
 Y4rL0WGc5W/8HxFYDm7Cvz/T0RfOuZgPxp6UN+RTWfm/i3KBqwt9E5KVm52HQ1zLB/toHSyU6
 k0CXQUZ9KFErAqhPKiMrn9kqYoqIcYuVB+UsqC2M2IN7nCeP1bDfBHZDo99wjo7qUTbWvAiBZ
 laiYC8qNqPl1fkYY2f7pPqBFdOs0ZrKVd39FpSM7bUcY6n/fcyUsuRlyOc7sJP8IgsVEkMhEz
 N3JVMbvs2yqCERYMC+4dtbeg8ztQg82ZJlSS1N0N+04CKpEk+9xbkzbVc3+yKfSryQ8xqpUnR
 MHN+Pt0D49C2I7WOfw6uwy5Ng9X54JNOiIHRRrnPz/JmamP3qNM5QPlnVo8k++RpJKDa9AWhh
 lknR4drQhVLIDWSrBrm8/BrVqNXYGVmiKRDc4XRF99CR5e1690bgDRRXPBXf1FQLifyVLnKks
 1tQk0TXeq5h+GgbwVgGaWqvDkw+RL38ckS2FBm/N4KrP+bKapASiM1YiQ==
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

Co-developed-by: Joe Perches <joe@perches.com>
Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
Hi Joe,

I have added the "Co-developed-by: Joe Perches" tag to give you credit,
since all the code used in this patch relies heavily on your review
code snippets.

I hope there are no objections.

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

Changelog v5 -> v6
- Rebase against v5.14.
- Refactor the code to use a more common scnprintf mechanism (Joe
  Perches).

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

v5
https://lore.kernel.org/linux-hardening/20210829161547.6069-1-len.baker@gm=
x.com/

 drivers/edac/edac_mc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index f6d462d0be2d..97dff62970a5 100644
=2D-- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1032,6 +1032,8 @@ void edac_mc_handle_error(const enum hw_event_mc_err=
_type type,
 	int i, n_labels =3D 0;
 	struct edac_raw_error_desc *e =3D &mci->error_desc;
 	bool any_memory =3D true;
+	const char *prefix =3D "";
+	int n =3D 0;

 	edac_dbg(3, "MC%d\n", mci->mc_idx);

@@ -1113,12 +1115,9 @@ void edac_mc_handle_error(const enum hw_event_mc_er=
r_type type,
 			p =3D e->label;
 			*p =3D '\0';
 		} else {
-			if (p !=3D e->label) {
-				strcpy(p, OTHER_LABEL);
-				p +=3D strlen(OTHER_LABEL);
-			}
-			strcpy(p, dimm->label);
-			p +=3D strlen(p);
+			n +=3D scnprintf(e->label + n, sizeof(e->label) - n,
+				       "%s%s", prefix, dimm->label);
+			prefix =3D OTHER_LABEL;
 		}

 		/*
@@ -1140,9 +1139,9 @@ void edac_mc_handle_error(const enum hw_event_mc_err=
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

