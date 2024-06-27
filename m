Return-Path: <linux-edac+bounces-1413-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 060E691AE2C
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 19:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C325B299D1
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 17:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46DB19D8B0;
	Thu, 27 Jun 2024 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chg/88jK"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED82D19AA48;
	Thu, 27 Jun 2024 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509602; cv=none; b=s0Qzm2BjfYxKMH/IHUo/GopspmXeDekBGCrNAC2de+L0T8ule+PYfAqgbUjUxfGCOJ68OzQc8VhDEdsQc96C4Q93pC4nxXsCX0xUKH7d7wzbtBZ3bn2ks5mnFkPwpkWzWCJMU9QLc+qetCE629Ki5EnckXiWwO5ErBnH7cBeIwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509602; c=relaxed/simple;
	bh=YHq0Y1+/9ES+aKYsEIHWalSLRrmTzHNw4gkOlg6Iw6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=co+fzohYEyrp+XeBklAYximzVE9NH6VSlHT++n19mFNS8/zoiXFcriIXTZG/Pz+XSANXPxe2dpkEkQgTe2owcFkMA3RES2AjEIm0rSPrseHxb3+tOnTcUTktJ6925DpDhyeMxjp7kTFFwTOZy4wJ+eA3LIlCa9fbB/UMrACGdBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chg/88jK; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ec3f875e68so90654701fa.0;
        Thu, 27 Jun 2024 10:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719509599; x=1720114399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISugwrJpK+qCNO3mL2KSTDUU9IbUyyHgug7HQ4HSe5U=;
        b=chg/88jKp6pPp/RTFoKlphqLO91Z8I/l/r9D0MH+8XL2OA22Z2UvRl59C7xSci2+NG
         bHgm+cK9Fs/2YJFY/nzjoLacvHRlR6a1az+qHk9W0QZOtvEGgbQbvWdAZCS8Tz54KxCE
         ohuSjFRpk9xPtcJNFUmc6SD4nluQtRK100my7m0MSS0e/3inNcG67X57zOkm/5uph+1C
         kdFUUpjbPdFURKWa8nLoyWBplC4Bzm08zFfDfAJqo4paBMqUXMslFaxPDE3r/8jHQkXF
         iDJOvW9kA8ciOPj6md6bC19iKpuNUzyav232qLol7+d78gUROkrpy4jgomND1iCydbq/
         8x3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509599; x=1720114399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISugwrJpK+qCNO3mL2KSTDUU9IbUyyHgug7HQ4HSe5U=;
        b=bk0PAxwFL1eBt4A9fPA7oBNtOXCEPTBu6ttBvfTGbAm/Hz8FydrcBY1uGUjBn8eZPe
         Dw1tyEptxQprqlfpeQ3yY1PYQ9b23wUKf3BbRdttJV7OlkA3HdjfAbQVJxQbgble6c+H
         dRk79QvBpRSQS9s5fuoUt6YBHDfBAWt0t2kNHHrBgrBKNbpi+2B6x0uSLsGYhTUhjdNw
         enLeo5XCbIXNYIUMNIcxR61Lv1b8YZ650Y2XShjtKUDrJMYA1y6DsLPaxHKWndKhBGgJ
         ffkgm32N4xDe2zVeN0h5pDXYh1bO1etsi4LVVdfgG50O5HNm5TJzFCRT/VrfRPcxxSFB
         3yiw==
X-Forwarded-Encrypted: i=1; AJvYcCW6T1Ez/RpChu4QHt9D6ebevSwrIkUruAQ/UeQh0e7G3ayXQHW1d6DWQDygfLApH9xXwwd+a4Qk691GrBkHWhA+4YP+Q7VzJ/OQgBoc8exOycgy12DvTgG3dDTMIdvu5LCqqwkSG6B4nw==
X-Gm-Message-State: AOJu0Yz4C6dOF6ZwDzQu9TUi3zEv8Prqh1MWJrccyKnwTvsroDXq/aaM
	v4e+kLHZCdLycUUPc1z5ZGVuxS63+rQX/o84HwLo/h2BInKBW45E
X-Google-Smtp-Source: AGHT+IFJKI9Xx+K5dwhq/UHl+CAPUoBjUFBUnEIN5qh4rNroF9Q1yIhmdU4HDUxxv9PnwR5qtx/vKw==
X-Received: by 2002:a2e:7a0a:0:b0:2ec:543e:909e with SMTP id 38308e7fff4ca-2ec5b378497mr88498941fa.15.1719509599129;
        Thu, 27 Jun 2024 10:33:19 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a4cf7a3sm3203691fa.135.2024.06.27.10.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:33:18 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v6 10/18] EDAC/synopsys: Drop redundant info from the error messages
Date: Thu, 27 Jun 2024 20:32:17 +0300
Message-ID: <20240627173251.25718-11-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627173251.25718-1-fancer.lancer@gmail.com>
References: <20240627173251.25718-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the custom error messages are needlessly long so the logged text
gets to be printed in several lines in console. There is some
duplicated/redundant information which can be freely removed from it: drop
the message prefix "DDR ECC error type:%s" since the resultant text
printed to the log by the edac_mc_printk() method will contain the error
type and the memory controller id referring to the device detected the
error anyway; with no harm to readability shorten out the phrase "Bit
Position" to being just "Bit".

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 8b7069bca600..23a2f56fcb74 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -478,13 +478,13 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ceinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type:%s Row %d Col %d Bank %d Bank Group %d Bit Position: %d Data: 0x%08x",
-				 "CE", pinf->row, pinf->col, pinf->bank,
-				 pinf->bankgrp, pinf->bitpos, pinf->data);
+				 "Row %d Col %d Bank %d Bank Group %d Bit %d Data 0x%08x",
+				 pinf->row, pinf->col, pinf->bank, pinf->bankgrp,
+				 pinf->bitpos, pinf->data);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type:%s Row %d Bank %d Col %d Bit Position: %d Data: 0x%08x",
-				 "CE", pinf->row, pinf->bank, pinf->col,
+				 "Row %d Bank %d Col %d Bit: %d Data: 0x%08x",
+				 pinf->row, pinf->bank, pinf->col,
 				 pinf->bitpos, pinf->data);
 		}
 
@@ -497,13 +497,12 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ueinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type :%s Row %d Col %d Bank %d Bank Group %d",
-				 "UE", pinf->row, pinf->col, pinf->bank,
-				 pinf->bankgrp);
+				 "Row %d Col %d Bank %d Bank Group %d",
+				 pinf->row, pinf->col, pinf->bank, pinf->bankgrp);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-				 "UE", pinf->row, pinf->bank, pinf->col);
+				 "Row %d Bank %d Col %d",
+				 pinf->row, pinf->bank, pinf->col);
 		}
 
 		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
-- 
2.43.0


