Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48EB3EC143
	for <lists+linux-edac@lfdr.de>; Sat, 14 Aug 2021 09:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237144AbhHNH4m (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 14 Aug 2021 03:56:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:60763 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236519AbhHNH4l (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 14 Aug 2021 03:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628927745;
        bh=ZZfa3D/xlj1AhWpX8cfXOHAVJvxO9sqXF8P5vPPNy68=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=LUpBBn4pE7R3svYl5tl/e8uMT5w73lp5XJqygBtQPA05Su0kJvxRcYcqYqOZqqaUF
         XZAjHrKOl+coh26CPl4qXoo92fDwbV6AmWlmWsD8kZaJ5idhx5IhyX0PdIPKSwisLY
         oFajPtA9BgwlMa1BfpjronVsKNOqcIWDIz0Jt1nc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1M1HZo-1mGTDH2G7e-002n4J; Sat, 14 Aug 2021 09:55:45 +0200
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
Subject: [PATCH v4] EDAC/mc: Prefer strscpy over strcpy
Date:   Sat, 14 Aug 2021 09:55:27 +0200
Message-Id: <20210814075527.5999-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:javi5gFL5vgU8bODNsXF3HGI+TugHhiTkzGQTTjX81sD3qjiqeF
 8N1cA2oYzzMXpiaj91SAM7RoivrD/xR2Ym3yTeajR5xn3cLdKGt9aMy89VEE2Kldm6xOcqU
 jkh3gT5bzUii5ik/f9+rE9sNAgB/o9e6LRKYh3/LJvAd7xmm2lojbRlsjzWqyk+ZAQF1fCr
 j8ZHinAr0RW0jKqDddTDA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wwa9qhrL6+M=:h0Ty1K8JmOj3iwQHBA6TxX
 F1mebYma032LVwQb9rtP4Ax43FXttpyTYbQfi/LyyYqCYStIYa09fLQ+6NMWIZerAoiS9wiUI
 ZsNfrW35NVRIb/2mMj7b0DWxWB/n6HKWF9rM+eCc/gCKZqOZMG2ZvRZ6a/4dXh2q9yjum4JYZ
 ZhtA1SZgrbxgOP7p4lEL/72FhKNfzEFejBcuHbJch1+tThcc1gWRH/xn40y6cWT6TcHjL9Ux/
 3sRy6aMpmD0GhrfENR3cXk9s3SuEe3WqNaa9vXkVt0IH0Cs/oQodx9AWfuPo9FrTk0CviXje8
 YvVdZhaxPsgIGz+ByTw55NvPyUY6osHTS/n5zmKmNLCSsFc0vWX8BY7lLqOn5J48V98yef11t
 2E2M+gbuDFoG2fckN260LvJtKA49dum52FOaYM2RglMwqkJp7k/XGEtWTokN27E6aUhhlUwgy
 Z+YOZTOYVqgYqTbvqpqK7i9rFU7vj0YE+9RoqALw9d6BJ5Hsi6j10I5j3D+AOm0ezUBWodkG5
 k+46er9ZNc5Nz7/iMCCCKDX8IwcmX6C4qOCzCJOSbtFNsQ3bKrPyGJ8p8nQeYjRZy2NHHVR6/
 MusqNmPsn1NnkxGob6JpxGlfrdJN2xJH4ZChW9cLaDCSu+93gi2xv9/M/0unQu/U1mDv5GWVD
 dNd1SBo23GLaF/NtxlBhTSpG55+Y9+wPSkSS9M6wAdD0WXc4E8bVcZdKiPPmG0wRhq0zfTRtK
 zKk4tQnTny2lQJOVSHhqXedcg+e/RBMt7ild6m/WjaY7bYDLI7EyP/nUS0619NlgrbvKqjBwi
 ghZ/a1teSk++5Cut1eIyMakQaCNG1KhUy74XTYUleEL4jNXIE7QH4ySIv2GW3iyzZ1HwtHoch
 n0+nmUFD4JQN4SSd4PRrNUnmHVPkgyEV6ZGEMwTlvNNGop+BraDe0NuVF4Ftxftbradxsrbl4
 BsR3uMfI7cULvQnUUIqn1InmRKGOEsbCV+AdLo68fKtwI/gInu/ecLmOaaPuvTi+oKsLcYbXI
 Vq8fZkrrh6Soqr+XCvXfR6K9n5iJQ0vWMfmKhLQxp+4SnijMX5XKUmf6EV/edXgXzJ3T9HWTH
 YzWyUNR7qAgXSIlrclD5DU+7IMmi9J241Q0L5pvFwlG4ntBO6zk/1f0Og==
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
Hi,

Following the comments in the previous version I don't use the scnprintf
function avoiding speed penalties. Instead I use the strscpy.

Thanks,
Len

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

Changelog v3 -> v4
- Change the commit subject (Joe Perches).
- Fix broken logic (Robert Richter).
- Rebase against v5.14-rc5.

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

 drivers/edac/edac_mc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index f6d462d0be2d..7aea6c502316 100644
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
@@ -1114,10 +1116,12 @@ void edac_mc_handle_error(const enum hw_event_mc_e=
rr_type type,
 			*p =3D '\0';
 		} else {
 			if (p !=3D e->label) {
-				strcpy(p, OTHER_LABEL);
-				p +=3D strlen(OTHER_LABEL);
+				strscpy(p, OTHER_LABEL, len);
+				len -=3D strlen(p);
+				p +=3D strlen(p);
 			}
-			strcpy(p, dimm->label);
+			strscpy(p, dimm->label, len);
+			len -=3D strlen(p);
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

