Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00DE312C6D8
	for <lists+linux-edac@lfdr.de>; Sun, 29 Dec 2019 18:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731995AbfL2Ru6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 29 Dec 2019 12:50:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:35786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731972AbfL2Ru6 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 29 Dec 2019 12:50:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D333C207FD;
        Sun, 29 Dec 2019 17:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641857;
        bh=pDa/f9AcJMh7khYqN1ssSqjeFxVXOoWorA1MKXmZNW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LWsomwJ5Ew1zjEatVArLVzPUAKra/XyxPWlocSV1gRTUGOSDdaBAE0dkY2G9aqjtF
         ZJxXcmob/fpo+jdrRhP3ukpPc3PLC4lIWWZ9tZkJLmZTva6Uj7nhY7LGFVAyGeP4xe
         uK4366L58/3dOZvjgtt5YR1Ixtrtqc3uQrO3jWRA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Tony Luck <tony.luck@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 187/434] EDAC/amd64: Set grain per DIMM
Date:   Sun, 29 Dec 2019 18:24:00 +0100
Message-Id: <20191229172714.243284613@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

[ Upstream commit 466503d6b1b33be46ab87c6090f0ade6c6011cbc ]

The following commit introduced a warning on error reports without a
non-zero grain value.

  3724ace582d9 ("EDAC/mc: Fix grain_bits calculation")

The amd64_edac_mod module does not provide a value, so the warning will
be given on the first reported memory error.

Set the grain per DIMM to cacheline size (64 bytes). This is the current
recommendation.

Fixes: 3724ace582d9 ("EDAC/mc: Fix grain_bits calculation")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Robert Richter <rrichter@marvell.com>
Cc: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20191022203448.13962-7-Yazen.Ghannam@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/amd64_edac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index c1d4536ae466..cc5e56d752c8 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2936,6 +2936,7 @@ static int init_csrows_df(struct mem_ctl_info *mci)
 			dimm->mtype = pvt->dram_type;
 			dimm->edac_mode = edac_mode;
 			dimm->dtype = dev_type;
+			dimm->grain = 64;
 		}
 	}
 
@@ -3012,6 +3013,7 @@ static int init_csrows(struct mem_ctl_info *mci)
 			dimm = csrow->channels[j]->dimm;
 			dimm->mtype = pvt->dram_type;
 			dimm->edac_mode = edac_mode;
+			dimm->grain = 64;
 		}
 	}
 
-- 
2.20.1



