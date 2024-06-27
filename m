Return-Path: <linux-edac+bounces-1406-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 050F891AE19
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 19:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33122879BF
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 17:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E7319B3CC;
	Thu, 27 Jun 2024 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVqSHeno"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5D019AA70;
	Thu, 27 Jun 2024 17:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509588; cv=none; b=Oiupg03JuXq1V6h35kMyhFp2armIv8xA5sAftJC/IqU5CaPyGhT5QSd1c6oOEQh96bm1Xf/AnC8fXXPnzl8voAiZqAaV5QhWnLRDkSH7TIFvo0AcHEHrBFSciaRzht0R4E5UaRM8qTc/4V2NqNQ5culmL1i9cgnC/I/cTWIia3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509588; c=relaxed/simple;
	bh=pckmSEsJNPwsJUkAID4CDz6TJ93XYOuNGufu4G05Tk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4Kfb2EaAhAXc5Fdaooyg7vVK0Ol8xWw0ghXgzDWBFUxTT1DlSxFsVop9yjH7RAbRH8J7d5tcArKePTP6cK4IlEsifacaRDHW/2XdU1fqRncyBJStWjcPxl5YXFLTMvP3yce2TeqMOhxI9TKyubBBajQXad0fWOg7vmAt7i+UsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVqSHeno; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52cd80e55efso11504911e87.0;
        Thu, 27 Jun 2024 10:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719509585; x=1720114385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpnyU51TlcwZB1aJFqoq6elUk1Qbwu0yTXRZ2IUO/Ns=;
        b=FVqSHenouc0exeBIP/JEsWMm0Y1uZp++FEDy+j93DVMCPirK99LYBrucAAnt/9sRas
         N53DVYtcBUnazzK78oA9rSiWqoqIkpo082O7dCEwW3cGAm/25GYDn1qJqP9Ttwqm+rHi
         qwr1Acb28fc3YOpYhDcG9oOg4IVS9muH/30TTx6ssZrVpOkNfbZAYCJyIUSqkfwcp+aW
         C3vG+YdgRppwLdrzczhFqUsRN2WL2Xt5b/GOCZYz9Ie+hriIvLPpZ8jh5TI2//vNVWyv
         0fh8TU5zjbrNiEAy3W1wh+xIivmOWqfx3H/3iHabQmLPpk52M6Wbg97jGcpQ2jVenfpm
         jeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509585; x=1720114385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CpnyU51TlcwZB1aJFqoq6elUk1Qbwu0yTXRZ2IUO/Ns=;
        b=ktZYfJDugimRm7cG/IherIgxHcQE6G8etdars0aVigjZCFXFM3JzKoflLL42WUh2kl
         GcuutybnvYnyMQjPdyp0h7pyX8rau/1nCTzQEKNIy6usUeSzPrheF+JWnbV/CUQm60VY
         ENPsX5lx1B2wzyH1hDrd82FY2lRwljguGDmj+cs2GFTnZo4vQSZJLG4cNQIgxpUZYwgt
         A0E4Se4A5XMHf9NNItK+RFf/uOjJP99mTzJfL+e+nwl0A8O8gJIerMm6FfRQnPUmAG4k
         j0bCNTSrkYtcy5DWEr2JbyHDStG53+pHgXZ7i3tFeh/1f5yGgzYBxZG2h4lDvYMtpldG
         NkrA==
X-Forwarded-Encrypted: i=1; AJvYcCVeevhn17jm81P6OtT88nt+92KqSV+lzQn8agD6hfYDhgH1IQM8anHBie2XfAtCjzhklfk3yaeas0rnsucqmp0yZ2gLmq476VZvcy7VfC50FxUfH3xAvynwPm53YwE1ZiHB0UrmXiZWzA==
X-Gm-Message-State: AOJu0Yyz/899DrH+E2qqfxK2LtrmFeUSwgIKL7vA+yboKLhYZ7OMNpRL
	jWKckhd3OqL6ywjF70viQCtLR8+x2IQsKAtS3nqJoVBjqsyjy9SH
X-Google-Smtp-Source: AGHT+IFEHhkB8yhij4kAlXfST4kw9Upo+PorcNLsuxqy3u4kWTIlMv/7PlPLfMHQtZbGuH+dFaHhtw==
X-Received: by 2002:a05:6512:138e:b0:52c:d76f:4604 with SMTP id 2adb3069b0e04-52ce1852745mr14344092e87.46.1719509584452;
        Thu, 27 Jun 2024 10:33:04 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e75434ef9sm137397e87.236.2024.06.27.10.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:33:04 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Manish Narani <manish.narani@xilinx.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Borislav Petkov <bp@suse.de>
Subject: [PATCH RESEND v6 03/18] EDAC/synopsys: Drop erroneous ADDRMAP4.addrmap_col_b10 parse
Date: Thu, 27 Jun 2024 20:32:10 +0300
Message-ID: <20240627173251.25718-4-fancer.lancer@gmail.com>
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

Currently the ADDRMAP4.addrmap_col_b10 field gets to be parsed in case of
the LPDDR3 memory and Quarter DQ bus width mode. It's wrong since that
field is marked as unused for that mode in all the available DW uMCTL2
DDRC releases (up to IP-core v3.91a). Most likely the field parsing was
added by mistake as a result of the copy-paste from the Half DQ bus width
mode part of the same function. Even though the field is supposed to be
always set to the UNUSED value (0x1F) drop parsing it anyway so to
simplify the setup_column_address_map() method a tiny bit.

Fixes: 1a81361f75d8 ("EDAC, synopsys: Add Error Injection support for ZynqMP DDR controller")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---
 drivers/edac/synopsys_edac.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 2b23d5ef9cff..88db777f3d90 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1236,10 +1236,6 @@ static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
 				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
 				 COL_B9_BASE);
-			priv->col_shift[13] = ((addrmap[4] &
-				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
-				((addrmap[4] & COL_MAX_VAL_MASK) +
-				 COL_B10_BASE);
 		} else {
 			priv->col_shift[11] = (((addrmap[3] >> 16) &
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
-- 
2.43.0


