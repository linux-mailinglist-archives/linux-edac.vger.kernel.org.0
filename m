Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC32066539
	for <lists+linux-edac@lfdr.de>; Fri, 12 Jul 2019 05:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbfGLDtU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 11 Jul 2019 23:49:20 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:38359 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729573AbfGLDtT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 11 Jul 2019 23:49:19 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5350A891B4;
        Fri, 12 Jul 2019 15:49:15 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1562903355;
        bh=02ghrJdoNyIhrZDPFsjbaOpdEUmOgsH7iT2rLeTfeyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=wTXiUdkZeaAsGCJV9p9PsIP8yGROOHv1bI0GRJKAjmWLj/+fzKIH/ctcaV8edjqfS
         TpyatjLy4TyNGdgMpS70MsX3iiXZkKD/JeZY73O2ngc3ITCBPRZId2K+Ydnu2EiaEa
         Qj/sc7z0veB92HaT/5aafVAmM4KgqcMJTmfo8fnFEPImP+n+RlkdbT1z1M/3SmxzHH
         x1uBW7uDvbbeD5NbriBcKfWwisRkRMArZ3Q3pkc6um6YX0ALgtH9KE9RsQ10aQ6zxZ
         BOCGZUKbTi3IlnbdEVheCQrC8UFJ+VjpCTGxkU9trh7C7awc2QjcXQ3E2JdxYf8ors
         0nGdgxb8ExNdw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5d28033a0006>; Fri, 12 Jul 2019 15:49:14 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 1D49313EF47;
        Fri, 12 Jul 2019 15:49:16 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 54A4F1E1D7A; Fri, 12 Jul 2019 15:49:14 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     bp@alien8.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, patches@armlinux.org.uk, mchehab@kernel.org,
        james.morse@arm.com, jlu@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v9 6/8] EDAC: Add missing debugfs_create_x32 wrapper
Date:   Fri, 12 Jul 2019 15:49:02 +1200
Message-Id: <20190712034904.5747-7-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712034904.5747-1-chris.packham@alliedtelesis.co.nz>
References: <20190712034904.5747-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Jan Luebbe <jlu@pengutronix.de>

We already have wrappers for x8 and x16, so add the missing x32 one.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v9:
    - Adapt debugfs_create_x32 to account for recent changes to debugfs a=
pis

 drivers/edac/debugfs.c     | 11 +++++++++++
 drivers/edac/edac_module.h |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/edac/debugfs.c b/drivers/edac/debugfs.c
index 1f943599a8ac..4804332d9946 100644
--- a/drivers/edac/debugfs.c
+++ b/drivers/edac/debugfs.c
@@ -138,3 +138,14 @@ void edac_debugfs_create_x16(const char *name, umode=
_t mode,
 	debugfs_create_x16(name, mode, parent, value);
 }
 EXPORT_SYMBOL_GPL(edac_debugfs_create_x16);
+
+/* Wrapper for debugfs_create_x32() */
+void edac_debugfs_create_x32(const char *name, umode_t mode,
+			     struct dentry *parent, u32 *value)
+{
+	if (!parent)
+		parent =3D edac_debugfs;
+
+	debugfs_create_x32(name, mode, parent, value);
+}
+EXPORT_SYMBOL_GPL(edac_debugfs_create_x32);
diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
index b2f59ee76c22..388427d378b1 100644
--- a/drivers/edac/edac_module.h
+++ b/drivers/edac/edac_module.h
@@ -82,6 +82,8 @@ void edac_debugfs_create_x8(const char *name, umode_t m=
ode,
 			    struct dentry *parent, u8 *value);
 void edac_debugfs_create_x16(const char *name, umode_t mode,
 			     struct dentry *parent, u16 *value);
+void edac_debugfs_create_x32(const char *name, umode_t mode,
+			     struct dentry *parent, u32 *value);
 #else
 static inline void edac_debugfs_init(void)					{ }
 static inline void edac_debugfs_exit(void)					{ }
@@ -96,6 +98,8 @@ static inline void edac_debugfs_create_x8(const char *n=
ame, umode_t mode,
 					  struct dentry *parent, u8 *value)	{ }
 static inline void edac_debugfs_create_x16(const char *name, umode_t mod=
e,
 					   struct dentry *parent, u16 *value)	{ }
+static inline void edac_debugfs_create_x32(const char *name, umode_t mod=
e,
+		       struct dentry *parent, u32 *value)			{ }
 #endif
=20
 /*
--=20
2.22.0

