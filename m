Return-Path: <linux-edac+bounces-410-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D548438D5
	for <lists+linux-edac@lfdr.de>; Wed, 31 Jan 2024 09:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A1A1F2906E
	for <lists+linux-edac@lfdr.de>; Wed, 31 Jan 2024 08:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA24B5731A;
	Wed, 31 Jan 2024 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYIjIA42"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14605D750
	for <linux-edac@vger.kernel.org>; Wed, 31 Jan 2024 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689472; cv=none; b=VG5UGtKMC1X1Taay1G+y+ew24mD5gqTX24zqD6kkyQ9MvDioTSfLUXDbsgiRoCmwI/zlNuZ/X7nphmWkmzXrlCnE5Wv5C9OAfAJpB0xJJMlOk+ZPyg/oARVV2JISKKZLqQOcnVklFi5CD1f6QlzNmqKGlnxCKATUCcxi9klRrWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689472; c=relaxed/simple;
	bh=ZnF7iKo/ZFbGkBB2MbsvheyNsQD3je4DZX7Au09k4DA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XZDg27InLcCf64MipnlRZ2fxfCO5b+vAWqDTxrZNHVMLkJMBsLYHnS1CvqRrgI6INDGbkdo1SfWXbq0Lv0oc1lpAVMSP9Dp0QxUHvtRhmnqaINE1hY0EikjDCXqqjS1r9Og90ooPV7TkvgayNcIcN2MXtnRzLtML8kDRbObRJ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LYIjIA42; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33ae4205ad8so2713487f8f.2
        for <linux-edac@vger.kernel.org>; Wed, 31 Jan 2024 00:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706689469; x=1707294269; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VlKKphLBogbuT0RBIYdtdc5+J5iprMNNjA2TgZhIPr8=;
        b=LYIjIA424ArZUH+A6k1TiLRxSqxKvN+2UragETnPzGYK0XyY/A2i7KxJtNErzRIR3q
         obmGR+XJOmgITikXmLhtGZUIc143UjrT4xqWmBgj9+dYLCKmCTy2d3sa/lhKCbC9srPm
         ncVoEeAtyexe4Oq12f/ufI3wv5hc5Ofh2Adfgd+KbHgmk9FhZy2bG8fWxNw6UtT8gopP
         iunBbS+p7MHmkh+rerDWPHLWSSjeMvlAtT8z4nsn7qKKfl3puDlR9QQu8FLIV8VWXy5+
         3HE+2HIhaza176QAbvU0pqs5DvRXu5GegkWeolkthvbrNcr9FQqFKOQ4ZEyjNctmYSEY
         ycrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706689469; x=1707294269;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VlKKphLBogbuT0RBIYdtdc5+J5iprMNNjA2TgZhIPr8=;
        b=oGRIy0h/xinjFMaIUsSuf55WuhmO2wvB/LmV4tWVG8699gMYRcE52V6tldxL2/d4cP
         QC8NgnEAN+PH17ymyLRekxL3cbXIQHK1EMCGlP/f0EfV2NrQk/H3tp98EsAGW13hwmkc
         1Ki8QT5OIWCz0vqZcaHgvwyitu87kJtyzNWBGLYJIRG1iWCYKHFtouwpZxIJbxsseeIz
         0Ebv82ZJ6xApmUtcbRLIdHkbdE0R7cLlo3xcj3JB9TmCG6Sh3iX/BdXOALDZ/vNfAU7B
         hXRdZM1uHzh5o1Sr/Ua5krmtbfu2A041k9B2NdcAmJ51xEqqcJMS3w36CN7YALsjU+8N
         HFfw==
X-Gm-Message-State: AOJu0YxRfCZsPFipzkqVdNvNQvn2axboq1bMXh8a09fZukCPxfnt/mFw
	YWwaA5p9GDfiT1UydOpw/OvwNf8bEmIbNOtazoc2lH7EwhJR7UhJwYguXNOtknvlXdRfNBX7iHN
	e
X-Google-Smtp-Source: AGHT+IG/KsmeYrAxJSxpF1zN165aGnxdGMtGJFaiuGGf+pE/DxpE2WAhuz1IAOCKENhXBOFFshzNUA==
X-Received: by 2002:a05:6000:25b:b0:33a:e52b:5a36 with SMTP id m27-20020a056000025b00b0033ae52b5a36mr470161wrz.44.1706689469111;
        Wed, 31 Jan 2024 00:24:29 -0800 (PST)
Received: from localhost ([102.140.226.10])
        by smtp.gmail.com with ESMTPSA id bj26-20020a0560001e1a00b0033ae6530969sm10016575wrb.85.2024.01.31.00.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:24:28 -0800 (PST)
Date: Wed, 31 Jan 2024 11:24:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Muralidhara M K <muralidhara.mk@amd.com>
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] RAS/AMD/ATL: Fix array overflow in
 get_logical_coh_st_fabric_id_mi300()
Message-ID: <279c8b5e-6c00-467a-9071-9c67926abea4@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Check against ARRAY_SIZE() which is the number of elements instead of
sizeof() which is the number of bytes.  Otherwise we potentially read
beyond the end of the phy_to_log_coh_st_map_mi300[] array.

Fixes: 453f0ae79732 ("RAS/AMD/ATL: Add MI300 support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/ras/amd/atl/denormalize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/amd/atl/denormalize.c b/drivers/ras/amd/atl/denormalize.c
index d5d0e1fda159..49a900e066f1 100644
--- a/drivers/ras/amd/atl/denormalize.c
+++ b/drivers/ras/amd/atl/denormalize.c
@@ -405,7 +405,7 @@ static const u16 phy_to_log_coh_st_map_mi300[] = {
 
 static u16 get_logical_coh_st_fabric_id_mi300(struct addr_ctx *ctx)
 {
-	if (ctx->inst_id >= sizeof(phy_to_log_coh_st_map_mi300)) {
+	if (ctx->inst_id >= ARRAY_SIZE(phy_to_log_coh_st_map_mi300)) {
 		atl_debug(ctx, "Instance ID out of range");
 		return ~0;
 	}
-- 
2.43.0


