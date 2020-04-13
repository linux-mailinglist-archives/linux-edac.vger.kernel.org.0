Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B39E1A63C6
	for <lists+linux-edac@lfdr.de>; Mon, 13 Apr 2020 09:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgDMHfC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Apr 2020 03:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbgDMHfC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 13 Apr 2020 03:35:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA292C008651;
        Mon, 13 Apr 2020 00:35:01 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so1224173wmh.3;
        Mon, 13 Apr 2020 00:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jNvpxtX/L+YMcC9uGmkISLCwGkRZNFiP+NPeaB0ugAk=;
        b=CAaTOHhrXd2f0/o9O0vjmpdMKqGTeG7I5T0YM4fecMsoVwj6PytUIeE6mJKgmIcvH4
         s9VlGD8cefVpVIb13UaC3kqH4HxbsszpnJ8WjpO1RmLigkzYCHO7nFfa6d9CvP5sycmi
         dSQoAoCDstvKUbhs8WBEZ/eMLne8IBfZqya52u8s8u87RHIlxDbLYouseoUyDcuttzWu
         gCz0iK54/pEvIUzzfe+U7iNls/UBZgI+3MQY/1KkY9R5c91WCq3DcPhctk1R1mPCYVMh
         cht9VNr5zHT5y4Fr8ktYv22GjDg3dxkA4sAVzw44Cldi9zoHSplxggVqsiUid1phBPIX
         u+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jNvpxtX/L+YMcC9uGmkISLCwGkRZNFiP+NPeaB0ugAk=;
        b=ceAV+i6gNUOYEySt9MuG60h3xrtBGzE4rh2ZTloVaypUDlw5dJ5/rSiRlWxan5ItFN
         KHmK5/Te9vhfCiBeUFGHoz7lMDA2SxxZMhMhnzx8lhSfiYvaaFTpCul8BG8ROnqBBEKJ
         WZpZvaC3JP8x79hcdCZQFOGf6x0EVI60yenb0eGvBETXungpuCUETaUDSWgh3EclZMwg
         933dYx8BRvkBXe8M54ZSw9U3+yYlblNcihCZeW0N3fMxJ3nasZCaupXLQKm/gF3wfLAz
         zsuq7/YFPoUhN1tAbDtTNGMkZvbs8BTO4T7w0GAiUpwpwfe4PwLwp+iSGSu8kl5BIKRi
         AGsg==
X-Gm-Message-State: AGi0PuadQDqXpq8VkuFjWQAp5mJuIXNk5gCNLxFHVDvJ6TcMfWPIDnHo
        WAYnnhKzM+zH2LY+jkQhs2M=
X-Google-Smtp-Source: APiQypI/zPo1GszUY9LqyhxKcL6TzejRe+86z7SOxoStPUo7xJSmZS5DYRN/oVfDW9ELOOvAspC5tw==
X-Received: by 2002:a1c:7416:: with SMTP id p22mr1053662wmc.80.1586763300441;
        Mon, 13 Apr 2020 00:35:00 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2da9:2f00:c0be:812e:7fb0:ebe0])
        by smtp.gmail.com with ESMTPSA id q9sm13673845wrp.61.2020.04.13.00.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 00:34:59 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@suse.de>,
        Yash Shah <yash.shah@sifive.com>, linux-edac@vger.kernel.org,
        Sebastian Duda <sebastian.duda@fau.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RESEND] MAINTAINERS: rectify EDAC-SIFIVE entry
Date:   Mon, 13 Apr 2020 09:34:47 +0200
Message-Id: <20200413073447.9284-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Commit 9209fb51896f ("riscv: move sifive_l2_cache.c to drivers/soc") moved
arch/riscv/mm/sifive_l2_cache.c to drivers/soc/sifive/sifive_l2_cache.c
and adjusted the MAINTAINERS EDAC-SIFIVE entry but slipped in a mistake.

Since then, ./scripts/get_maintainer.pl --self-test complains:

  warning: no file matches F: drivers/soc/sifive_l2_cache.c

Rectify the EDAC-SIFIVE entry in MAINTAINERS now.

Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Paul, please pick this patch.

v1: https://lore.kernel.org/lkml/20200304144045.15060-1-lukas.bulwahn@gmail.com/
  - was not picked up.

v1-resend: applies on v5.7-rc1

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..e28676766b26 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6172,7 +6172,7 @@ M:	Yash Shah <yash.shah@sifive.com>
 L:	linux-edac@vger.kernel.org
 S:	Supported
 F:	drivers/edac/sifive_edac.c
-F:	drivers/soc/sifive_l2_cache.c
+F:	drivers/soc/sifive/sifive_l2_cache.c
 
 EDAC-SKYLAKE
 M:	Tony Luck <tony.luck@intel.com>
-- 
2.17.1

