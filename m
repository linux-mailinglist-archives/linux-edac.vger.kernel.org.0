Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D364D19B65
	for <lists+linux-edac@lfdr.de>; Fri, 10 May 2019 12:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfEJKQb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 May 2019 06:16:31 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:47660 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfEJKPn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 10 May 2019 06:15:43 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3E550891AF;
        Fri, 10 May 2019 22:15:40 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1557483341;
        bh=ta9F3sFG5pwxpKirorpYus2FIg7P+3XQmasHLOw8R9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TRbSFBSMEIurwJCoNu7kBp5acJtq+zFGMdfqUwzyMSspDMNNRVHlk79dMSF0hUBj0
         uItRt/Td8zI+s9ST0OLSp7irIIJWd+KRbBsiUYzMuhtNh4vjIaEmRdKz9Py21i1DbV
         5ICnWUFnfXT+/fI94k21eq/2W/8Jo8ou6NZPf3DYuGvhwhQSNczGowVaz3DDND1QBb
         fAFMSavMYWg0+uOIjPC3O4tKwQUdwbT8r2uOWBlkjZvY8EGwtjOEa2QXvOtWj9xa3y
         ybwi+APyutfFeUItZti9mlzBYHJrLoj0Joa/ONm3YTekugS4JEFlUVX1OXlIY07XQm
         E+7vYYMnh5iTw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5cd54f4d0003>; Fri, 10 May 2019 22:15:41 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 6D61313EFA1;
        Fri, 10 May 2019 22:15:40 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 0248E1E1D5B; Fri, 10 May 2019 22:15:39 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     linux@armlinux.org.uk, bp@alien8.de, mark.rutland@arm.com,
        robh+dt@kernel.org, mchehab@kernel.org, james.morse@arm.com,
        jlu@pengutronix.de, gregory.clement@bootlin.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v8 7/9] EDAC: Add missing debugfs_create_x32 wrapper
Date:   Fri, 10 May 2019 22:15:34 +1200
Message-Id: <20190510101536.6724-8-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190510101536.6724-1-chris.packham@alliedtelesis.co.nz>
References: <20190510101536.6724-1-chris.packham@alliedtelesis.co.nz>
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
 drivers/edac/debugfs.c     | 11 +++++++++++
 drivers/edac/edac_module.h |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/edac/debugfs.c b/drivers/edac/debugfs.c
index 0a9277228c50..91b156b1f0c1 100644
--- a/drivers/edac/debugfs.c
+++ b/drivers/edac/debugfs.c
@@ -137,3 +137,14 @@ struct dentry *edac_debugfs_create_x16(const char *n=
ame, umode_t mode,
 	return debugfs_create_x16(name, mode, parent, value);
 }
 EXPORT_SYMBOL_GPL(edac_debugfs_create_x16);
+
+/* Wrapper for debugfs_create_x32() */
+struct dentry *edac_debugfs_create_x32(const char *name, umode_t mode,
+				       struct dentry *parent, u32 *value)
+{
+	if (!parent)
+		parent =3D edac_debugfs;
+
+	return debugfs_create_x32(name, mode, parent, value);
+}
+EXPORT_SYMBOL_GPL(edac_debugfs_create_x32);
diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
index dd7d0b509aa3..9822f1a7e194 100644
--- a/drivers/edac/edac_module.h
+++ b/drivers/edac/edac_module.h
@@ -82,6 +82,8 @@ struct dentry *
 edac_debugfs_create_x8(const char *name, umode_t mode, struct dentry *pa=
rent, u8 *value);
 struct dentry *
 edac_debugfs_create_x16(const char *name, umode_t mode, struct dentry *p=
arent, u16 *value);
+struct dentry *
+edac_debugfs_create_x32(const char *name, umode_t mode, struct dentry *p=
arent, u32 *value);
 #else
 static inline void edac_debugfs_init(void)					{ }
 static inline void edac_debugfs_exit(void)					{ }
@@ -98,6 +100,9 @@ edac_debugfs_create_x8(const char *name, umode_t mode,
 static inline struct dentry *
 edac_debugfs_create_x16(const char *name, umode_t mode,
 		       struct dentry *parent, u16 *value)			{ return NULL; }
+static inline struct dentry *
+edac_debugfs_create_x32(const char *name, umode_t mode,
+		       struct dentry *parent, u32 *value)			{ return NULL; }
 #endif
=20
 /*
--=20
2.21.0

