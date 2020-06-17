Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2F01FC35D
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jun 2020 03:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgFQBdG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Jun 2020 21:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFQBdE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 Jun 2020 21:33:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9DDC061573;
        Tue, 16 Jun 2020 18:33:04 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d66so331549pfd.6;
        Tue, 16 Jun 2020 18:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F4Sg2Fx/1M7WXvaXNZ3VgjgEeNY44jhbmLmw78OkRmo=;
        b=VWaFVykUSvYs3m6Vt/KZmTIhdFNe4Y2Wm6XohxWW4uAgYtSFNjG8G6EO5l7kEsa2Cx
         EJ8W0hWRnfJrMI11Cl+lKoCFN5RoMgmfmtu0l3wbGEOVFPot3xryO2C0dw29I/b4Mb8F
         Gj+9WNKQU6Z6mdzyI46kOi+g1Bk9WL/a27oyt7bzKSRubvljCTyQoxlDyX8/2HImOi3B
         11hn/Dki/1Ztk+5ekv4jzcRkvpaeCUT7tjvM+F9yT4ZQ9WUI6IxSNQSLm0MF0RNdPaVc
         EtxfvnhWNPvwuOCFPHQyfTS0SKa1XpjjBxPOvNOw7JtN30PKvnOzjrf2p/XyNzREVAxF
         nWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F4Sg2Fx/1M7WXvaXNZ3VgjgEeNY44jhbmLmw78OkRmo=;
        b=DJYf49CVeklmHWyU8LiVoP2YVANNlOI7V+85keW0Cpz6I4s0II9zaL3PYppUNV8h5S
         lepQnocE0hGCLxVNxUGI8EorpSxykOAKjPnQVVtrm9+xP/5AIaAXYkzqKn1dXGry40v7
         0GH0yuPN6tvdg5OvVvV5XjwaKJssX+okqSioDMFELkIcPwoIej9EBE7fUvAFxY6jzVgS
         HIglMdli0wrv5zI1vjCAQqRpo5NxNfkWH0V7grp+g4ZeoqDxonVUQ1vOX6pTzf/7hfM8
         ObTjcoP8rKBVz6L3FYwVnbc/5Obp1rXmpwP4opcsF6Reyw09xbGLjLNX/gE+WDYRCj10
         VxgA==
X-Gm-Message-State: AOAM533fMhTbAuJz0rDcjjcNATjC3BSJ3A+e51sqeGMwLf0exr4eoJxr
        s8W9gxvKYj1Z1kFosi1sxvXllxp+gu0O
X-Google-Smtp-Source: ABdhPJx4/k6bC1ZziEgJu3dHv6NWMpxAeuroLXSPrEvGKWJ88jeBHPwGmH/DcX3vKUj2AR157qFlXA==
X-Received: by 2002:a63:2f43:: with SMTP id v64mr4266868pgv.232.1592357583681;
        Tue, 16 Jun 2020 18:33:03 -0700 (PDT)
Received: from localhost (98.86.92.34.bc.googleusercontent.com. [34.92.86.98])
        by smtp.gmail.com with ESMTPSA id m5sm15534825pga.3.2020.06.16.18.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 18:33:02 -0700 (PDT)
From:   Jacky Hu <hengqing.hu@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org, yazen.ghannam@amd.com,
        bp@alien8.de, linux@roeck-us.net, clemens@ladisch.de,
        Jacky Hu <hengqing.hu@gmail.com>
Subject: [PATCH] hwmon: (k10temp) Add AMD family 17h model 60h probe
Date:   Wed, 17 Jun 2020 09:32:55 +0800
Message-Id: <20200617013255.391975-1-hengqing.hu@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616180940.GN13515@zn.tnic>
References: <20200616180940.GN13515@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

With this patch applied, output from 4800H (idle) looks as follows:

k10temp-pci-00c3
Adapter: PCI adapter
Vcore:         1.55 V
Vsoc:          1.55 V
Tctl:         +49.6°C
Tdie:         +49.6°C
Icore:         0.00 A
Isoc:          0.00 A

Signed-off-by: Jacky Hu <hengqing.hu@gmail.com>
---
 drivers/hwmon/k10temp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 8f12995ec133..287e9cf2aab9 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -583,6 +583,7 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			k10temp_get_ccd_support(pdev, data, 4);
 			break;
 		case 0x31:	/* Zen2 Threadripper */
+		case 0x60:	/* Zen2 APU */
 		case 0x71:	/* Zen2 */
 			data->show_current = !is_threadripper() && !is_epyc();
 			data->cfactor[0] = CFACTOR_ICORE;
-- 
2.27.0

