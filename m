Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA30F3D4EBA
	for <lists+linux-edac@lfdr.de>; Sun, 25 Jul 2021 18:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhGYPuI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 25 Jul 2021 11:50:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:48835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230193AbhGYPuI (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 25 Jul 2021 11:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627230618;
        bh=inD30o7fr9HcxF9taP8HiHZq0ZN5J2YqNni60Np4MPk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Eej6Y8wgB1/kwWEMxjPGkX+PLv84lfkmiV5MyuWOVkf9W5Pub1aubjP3GzK02LX2q
         r+3koRyGkS8wURWzD0tdYPSiKf5z2dXPv5pNiGUdbFLcMFilg2fSrG/lN56lf40/g7
         HYbMXtrC89ckGfRZNHFN38S6IHMrA8LFSuvogYZc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1N3KPq-1l8c9Y1E70-010Ko9; Sun, 25 Jul 2021 18:30:18 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Cc:     Len Baker <len.baker@gmx.com>, linux-hardening@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/edac/edac_mc: Remove all strcpy() uses
Date:   Sun, 25 Jul 2021 18:29:54 +0200
Message-Id: <20210725162954.9861-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RcDpyTs3tg4lp5vwmLff6QfXiml+Js3YwTcnzeFtCngo+zS60VM
 C0Q6RF9CfEIDVAjFynbSn1ayQE7EB+tNnSah+pGB3LagJJEgljRNaFC1lviLtU/+7d14VLN
 mVLpbFFDbtsQzLZccifhoFZIItJE8drCvK8etTIjCW3IjEa1Qh4No9Ctdzl6Hm2oAid+01n
 NIMgn5a8fSafCYmaQjxtg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TEVbalbuEK8=:WWWdk8KU1PPpfa/dhyH+0s
 VwpLQOnOADnqnaPqyM4QaReAFkiHlgm+VrSQfepW22qf/+irs/qLsq3Il4B26JkHoPtoiQSrc
 lqA+85+oSWQudWUz5DYoI0eO+uWzKLdCP2WoDlE/jpqh5y9edyPUlS8hG97MJ4j+5p8TCLCUx
 wKbONbXJhVcX28zL5dR8mIibsxlwjLbEe1cI1tx2UNiVSLluh6WEDPOfNPhG9tVlqmVXwrxkb
 mXo/cFK3tW972lprKDHNY66981vunPxvWGm8eKwsPbcwFjTPyy+Cc3hMgynaoabiU1jPbSt36
 pMZPZaMrbZflcU17JI6NZF8qyj9NBVBPTD5V/hCfZoYBfQ6eU/NrpJVQzJHC+TBHj7HDlVVH5
 cFrRCKZCv9PKervHuKulAtozPdNwuYcn4o7uNfoaBdIbhU5soALjtZkzj7TPXJQ9F6R7ez56l
 lzKNhUqO41+9+rqd+VtTETQexY7Ho70hfs4CxCD/ccO6HRObck0jdvTxrmOLrWZ6g2sGMXSXy
 heAuPZbOGBSqpJAjlZ336WjKb8hgoQ2/QAh72jJSs0mm+hjDIQrZl6+vIIkTo8iYbOHjppU15
 32/Jd0g/lWVGaEs0KN+uopLw0ztJR7qFMKk6oPXe59NuninYCpqh+P8tmRzjRTbXdp4waGKRv
 1HhkERPNV9ZgCRFofevVg256C2WMowRQfHr75Bq96iSUrA5HhV2TGLOxLwHy9vRfpZYxFhzVw
 qBPRECIQKI7qffO7Tb5qnqd28oGBYfhnf8BJJR5nRURTp64QqLNnI05Wd/NNzmtdhe0RnXbSK
 DPCGz9CSIKII7zhZDimJLrTZpbfzlylcxOU1ZssxluV3hdL0jGGxAuO9QcohSdKb081/IBmVO
 iIuim2EzoV+gEslMbClNRUiujhRwxsHkO9MpCbPWmnkUw7rTwXl73zWj5FIEJHefAt1YAc5gF
 4tS79eUodpQQBzVuzdlofb3S2EfptlbDWlEOgYlB67y4vQ6xndS7DuRahTk0eUbcjzUC7Ny1x
 0PYDBlu9NkXp1wNSOPElNashjh5tJXUT/JXJVjXWcpZXoP91DkoeBNg5X8TRJM8YXd/qgLw+G
 wq0BviEUyAKnznWCxN2CP2jpjlG8N5C21aW
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. The safe replacement is strscpy().

However, to add labels is better to use the scnprintf to simplify the
arithmetic.

This is a previous step in the path to remove the strcpy() function
entirely from the kernel.

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
This is a task of the KSPP [1]

[1] https://github.com/KSPP/linux/issues/88

 drivers/edac/edac_mc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index f6d462d0be2d..1286364f0e48 100644
=2D-- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -1027,6 +1027,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err=
_type type,
 {
 	struct dimm_info *dimm;
 	char *p;
+	size_t p_size =3D 0;
 	int row =3D -1, chan =3D -1;
 	int pos[EDAC_MAX_LAYERS] =3D { top_layer, mid_layer, low_layer };
 	int i, n_labels =3D 0;
@@ -1113,12 +1114,11 @@ void edac_mc_handle_error(const enum hw_event_mc_e=
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
+			p_size +=3D scnprintf(p + p_size,
+					    sizeof(e->label) - p_size,
+					    "%s%s", or, dimm->label);
 		}

 		/*
@@ -1140,9 +1140,9 @@ void edac_mc_handle_error(const enum hw_event_mc_err=
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

