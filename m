Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDCD33D49F
	for <lists+linux-edac@lfdr.de>; Tue, 11 Jun 2019 19:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406539AbfFKRyg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 Jun 2019 13:54:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405972AbfFKRyg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 11 Jun 2019 13:54:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 076352086D;
        Tue, 11 Jun 2019 17:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560275675;
        bh=jbJnNmO9enRg4uIrsnreAbpALsd329VzH3q7BKkMg6s=;
        h=Date:From:To:Cc:Subject:From;
        b=VGCy7gT/gzyAg7YskBxQEVCwn8L0lSXUQitm9n9YK1aoPp7y9U3Qw3cNZ3r+RfiMt
         KJ5BoyWIJEYycqok+8/Z0Rsv19kv5u0Vny8bwwxh5s8FyO0K78R337wPqCanPy8uUa
         xHnVi8Rz8TgHdwDPgat4ATbovqfzQqUozw2Nq7nc=
Date:   Tue, 11 Jun 2019 19:54:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>
Cc:     linux-edac@vger.kernel.org
Subject: [PATCH] edac: make edac_debugfs_create_x*() return void
Message-ID: <20190611175433.GA5108@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The return values of edac_debugfs_create_x16() and
edac_debugfs_create_x8() are never checked (as they don't need to be),
so no need to have them return anything, just make the functions return
void instead.

This is done with the goal of being able to change the debugfs_create_x*
functions to also not return a value.

Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: <linux-edac@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/edac/debugfs.c     | 12 ++++++------
 drivers/edac/edac_module.h | 18 ++++++++----------
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/debugfs.c b/drivers/edac/debugfs.c
index 6b8e484db851..1f943599a8ac 100644
--- a/drivers/edac/debugfs.c
+++ b/drivers/edac/debugfs.c
@@ -118,23 +118,23 @@ edac_debugfs_create_file(const char *name, umode_t mode, struct dentry *parent,
 EXPORT_SYMBOL_GPL(edac_debugfs_create_file);
 
 /* Wrapper for debugfs_create_x8() */
-struct dentry *edac_debugfs_create_x8(const char *name, umode_t mode,
-				       struct dentry *parent, u8 *value)
+void edac_debugfs_create_x8(const char *name, umode_t mode,
+			    struct dentry *parent, u8 *value)
 {
 	if (!parent)
 		parent = edac_debugfs;
 
-	return debugfs_create_x8(name, mode, parent, value);
+	debugfs_create_x8(name, mode, parent, value);
 }
 EXPORT_SYMBOL_GPL(edac_debugfs_create_x8);
 
 /* Wrapper for debugfs_create_x16() */
-struct dentry *edac_debugfs_create_x16(const char *name, umode_t mode,
-				       struct dentry *parent, u16 *value)
+void edac_debugfs_create_x16(const char *name, umode_t mode,
+			     struct dentry *parent, u16 *value)
 {
 	if (!parent)
 		parent = edac_debugfs;
 
-	return debugfs_create_x16(name, mode, parent, value);
+	debugfs_create_x16(name, mode, parent, value);
 }
 EXPORT_SYMBOL_GPL(edac_debugfs_create_x16);
diff --git a/drivers/edac/edac_module.h b/drivers/edac/edac_module.h
index dd7d0b509aa3..bc4b806dc9cc 100644
--- a/drivers/edac/edac_module.h
+++ b/drivers/edac/edac_module.h
@@ -78,10 +78,10 @@ edac_debugfs_create_dir_at(const char *dirname, struct dentry *parent);
 struct dentry *
 edac_debugfs_create_file(const char *name, umode_t mode, struct dentry *parent,
 			 void *data, const struct file_operations *fops);
-struct dentry *
-edac_debugfs_create_x8(const char *name, umode_t mode, struct dentry *parent, u8 *value);
-struct dentry *
-edac_debugfs_create_x16(const char *name, umode_t mode, struct dentry *parent, u16 *value);
+void edac_debugfs_create_x8(const char *name, umode_t mode,
+			    struct dentry *parent, u8 *value);
+void edac_debugfs_create_x16(const char *name, umode_t mode,
+			     struct dentry *parent, u16 *value);
 #else
 static inline void edac_debugfs_init(void)					{ }
 static inline void edac_debugfs_exit(void)					{ }
@@ -92,12 +92,10 @@ edac_debugfs_create_dir_at(const char *dirname, struct dentry *parent)		{ return
 static inline struct dentry *
 edac_debugfs_create_file(const char *name, umode_t mode, struct dentry *parent,
 			 void *data, const struct file_operations *fops)	{ return NULL; }
-static inline struct dentry *
-edac_debugfs_create_x8(const char *name, umode_t mode,
-		       struct dentry *parent, u8 *value)			{ return NULL; }
-static inline struct dentry *
-edac_debugfs_create_x16(const char *name, umode_t mode,
-		       struct dentry *parent, u16 *value)			{ return NULL; }
+static inline void edac_debugfs_create_x8(const char *name, umode_t mode,
+					  struct dentry *parent, u8 *value)	{ }
+static inline void edac_debugfs_create_x16(const char *name, umode_t mode,
+					   struct dentry *parent, u16 *value)	{ }
 #endif
 
 /*
-- 
2.22.0

