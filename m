Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685037071CB
	for <lists+linux-edac@lfdr.de>; Wed, 17 May 2023 21:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjEQTRI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 May 2023 15:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjEQTRH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 May 2023 15:17:07 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D05635BC;
        Wed, 17 May 2023 12:17:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ae4be0b1f3so9604895ad.0;
        Wed, 17 May 2023 12:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684351026; x=1686943026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LanXL4cSjsGDYSSD0FSs2zO2brIePGo9H9nGrxSamac=;
        b=cOADYCKrXZvPD11VXf7AXxA/Noml5RKbZfZ32QgzGekH7ufXcDbscir85yncraiskI
         3/1uiBWFrnnIh6pViv6i4sfQl6jQ1omaCo7iJznH6jzLbBf90XbIo2fFdGORGOIksYu5
         nGnOTasoErUP5KEifdn7QEo0LmtGdBkgkhBB7LlcX428pWe+tpYrQyXzdO28WjcJQMKC
         vNRWlQaELarsWFNXkLnEaxgQd1rmWPuPm0mmeTwXroOvIdQ/a3yqW5oYnk8QsfkgVCZr
         MNidIgg0bLEetkobR4wFI0e4tMiB5AbxlCi3W+Z9BoIWbmtOPadOX2HJXwSgCr6T1eF4
         cBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684351026; x=1686943026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LanXL4cSjsGDYSSD0FSs2zO2brIePGo9H9nGrxSamac=;
        b=ac5HoVvXwot4psAnq+IVHp82ajGI7om2u6V1Bi3m5GJ/adRrUZH7aWERADRJKzVL1g
         EiF2+VWG1+MK9KojMRSboHAk1rsDCVHsp2jDdebc5dy0gJmP+PXRFd2CPGoM/eSDG4XS
         mPOViwZS1lyRF8EIPoUPXGOYsBpCELWXZyxg/oHhNvZKE9M/X2Gxx53yWTa5Z9h//ut5
         Dte0moYCcXV+gLlQLzQ5FtIhHj+d/US458bEMuE5DlJ8LJtyKUblFjGT1KJkEfu+VP7H
         vwvDfsOwqxAEoBIzzaJsY13V4NFMvDRBStKhxu6X/JINhVstuEUIGlnz3UOhimkxZ3Q5
         nw0w==
X-Gm-Message-State: AC+VfDyE3DLOOyJiLhgkjKZd+lIt7EUzIyaRgfEH71/WMVYxJhI1MYfT
        usEmGCOsh6ZNr1FiCvvBbRU=
X-Google-Smtp-Source: ACHHUZ7b9gqpxVRtD0xI0+8yT36VHR3Gh7qFSeCjIat07BTqPuDEZzpCbUEhf0KHEjrbK02f2JeMhQ==
X-Received: by 2002:a17:903:182:b0:1ac:8be5:8787 with SMTP id z2-20020a170903018200b001ac8be58787mr38973015plg.21.1684351026519;
        Wed, 17 May 2023 12:17:06 -0700 (PDT)
Received: from localhost.localdomain ([111.201.128.95])
        by smtp.gmail.com with ESMTPSA id z2-20020a170903018200b001acad86ebc5sm16215089plg.33.2023.05.17.12.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:17:06 -0700 (PDT)
From:   Yeqi Fu <asuk4.q@gmail.com>
To:     dinguyen@kernel.org, bp@alien8.de, tony.luck@intel.com
Cc:     Yeqi Fu <asuk4.q@gmail.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC/altera: Fix error checking
Date:   Thu, 18 May 2023 03:15:56 +0800
Message-Id: <20230517191556.367689-1-asuk4.q@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The function edac_debugfs_create_dir returns ERR_PTR if an error
occurs, and the appropriate way to verify for errors is to use the
inline function IS_ERR. The patch will substitute the null-comparison
with IS_ERR.

Signed-off-by: Yeqi Fu <asuk4.q@gmail.com>
---
 drivers/edac/altera_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 8b31cd54bdb6..19693333408f 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -683,7 +683,7 @@ static void altr_create_edacdev_dbgfs(struct edac_device_ctl_info *edac_dci,
 		return;
 
 	drvdata->debugfs_dir = edac_debugfs_create_dir(drvdata->edac_dev_name);
-	if (!drvdata->debugfs_dir)
+	if (IS_ERR(drvdata->debugfs_dir))
 		return;
 
 	if (!edac_debugfs_create_file("altr_trigger", S_IWUSR,
-- 
2.37.2

