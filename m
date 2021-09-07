Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713CB40277A
	for <lists+linux-edac@lfdr.de>; Tue,  7 Sep 2021 12:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343718AbhIGLAf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 7 Sep 2021 07:00:35 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:56410
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343706AbhIGLAV (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 7 Sep 2021 07:00:21 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8867841A67;
        Tue,  7 Sep 2021 10:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631012353;
        bh=Nbbb7rLVgfd4DDptZCzReFRmpedOnCrgnNcVj4VWs3M=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=TR+TFdvPZ4rVGF1NV9aD6EJssenTUuVJYmAjN+S+HYRHgEYgqiffLDyqOd4pQISnv
         6R0UdwG4JcdLDF+Dh0loz2Y07tP2ulWSapTj4EOqbGCkrQr0jHzZvbFVUIi5uGgd2u
         uzc0R3tvZfCRfFO38Hi5KDjHPVK23ncXjwISeI7HaMTG5XeRSB3nmCrz/emy0rqeaa
         0LRMYrWXgJHBS9IRpWDZT56HmlteMNU0lg+w6a5Zuyoq3QBeuBE3tO7TFWE8Z1W2OV
         +9jwydBF5v+2vTku/wmSr27NpwihMQSESNc1buQz3YFpcPvdZTSWNDj8KTebZXNKGZ
         x0N7eljChCiRg==
From:   Colin King <colin.king@canonical.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC/device: Remove redundant initialization of pointer dev_ctl
Date:   Tue,  7 Sep 2021 11:59:13 +0100
Message-Id: <20210907105913.15077-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable dev_ctl is being initialized with a value that is never
read, it is being updated later on. The assignment is redundant and
can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/edac/edac_device.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
index 8c4d947fb848..a337f7afc3b9 100644
--- a/drivers/edac/edac_device.c
+++ b/drivers/edac/edac_device.c
@@ -75,7 +75,6 @@ struct edac_device_ctl_info *edac_device_alloc_ctl_info(
 	 * provide if we could simply hardcode everything into a single struct.
 	 */
 	p = NULL;
-	dev_ctl = edac_align_ptr(&p, sizeof(*dev_ctl), 1);
 
 	/* Calc the 'end' offset past end of ONE ctl_info structure
 	 * which will become the start of the 'instance' array
-- 
2.32.0

