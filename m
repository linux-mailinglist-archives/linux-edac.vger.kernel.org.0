Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D3E42ACF7
	for <lists+linux-edac@lfdr.de>; Tue, 12 Oct 2021 21:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbhJLTJW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Oct 2021 15:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:32872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233287AbhJLTJU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 12 Oct 2021 15:09:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E5B860E09;
        Tue, 12 Oct 2021 19:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634065638;
        bh=NvMXR+4Usl2rtR3OS7hkHAbHRkGS7009/ooHLmyiRpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aFoHYXY/VjP1zbmJJxlGRdqfCNffdBP3v/dmMe3+1WovkSA5gdUhRppzi63h5qziy
         WhikwQMnEBJgISdPETHf7VcW0cBF7Pz4HWsGMBDHGoQTWT6995bCYfh1MgRHp1F73w
         mS/jgpqVSAMTzPlIGrdir0m/rd5+wAN3xrxm2BtTzHOeI3LJ9WVlwcNvENeObXTgf0
         Xj+3dPWguwsmibReGjuA/QAxOwKZPv6T1XZ//ibaVWFVAkOz/uK666IOX22JcWnwUa
         /azsn5Abf4LBMQZNGy4X8jt14zVxW17YPyXFjFimGQbnuzgmFpLR+HPJ8kw+E60Vkz
         D8kEoZWrqRrug==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     bp@alien8.de
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCHv4 4/4] dt-bindings: memory: add entry for version 3.80a
Date:   Tue, 12 Oct 2021 14:07:09 -0500
Message-Id: <20211012190709.1504152-4-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211012190709.1504152-1-dinguyen@kernel.org>
References: <20211012190709.1504152-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add an entry for version 3.80a of the Synopsys DDR controller.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 .../bindings/memory-controllers/synopsys,ddrc-ecc.yaml           | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml b/Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
index a24588474625..fb7ae38a9c86 100644
--- a/Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/synopsys,ddrc-ecc.yaml
@@ -26,6 +26,7 @@ properties:
     enum:
       - xlnx,zynq-ddrc-a05
       - xlnx,zynqmp-ddrc-2.40a
+      - snps,ddrc-3.80a
 
   interrupts:
     maxItems: 1
-- 
2.25.1

