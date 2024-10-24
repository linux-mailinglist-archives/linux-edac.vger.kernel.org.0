Return-Path: <linux-edac+bounces-2231-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710C89ADF0A
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 10:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2754728A5D7
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 08:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2831B392C;
	Thu, 24 Oct 2024 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vzmcv6M/"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57FC1AF0BC
	for <linux-edac@vger.kernel.org>; Thu, 24 Oct 2024 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758052; cv=none; b=HOIwd0gFA+zSnJXfcPQ/CBOTeNzH01LP03F8SMK4fVea0skT9xi8wdihMm+k40UA5OxcYa4UaMNHokc0RHfk+Ko2jXYsjUq5/ts2E+E3NWgU0xAieT/P+p+OG7wuacLr6edJRjWyKZij9/9j5tMKE2is9k9VjnlR3y+dI3aS3L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758052; c=relaxed/simple;
	bh=L+l/EN+WevNRX8zlMqajghYzv+6O7kk5ph+3ZCVzq78=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U81rCTkmykh/y62O6Crz2RqOhNP+o4bkVHRq60JY+bGEjF6pom3S2A8/JwKkZ/gsxo3/olyakIIeA0kjuY9fIn+ar/GsU27roUA4iRa2O46Cuflvif/N0SlCWaIFgK1hVXCEooWQIqgTYn2hQB3Am/XKwTsjQ6ZjYFjZlyVkpi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vzmcv6M/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d462c91a9so399601f8f.2
        for <linux-edac@vger.kernel.org>; Thu, 24 Oct 2024 01:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729758049; x=1730362849; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e2kiKp4RgrfPbI2NGuX12q84a3Rc1kCYks5Y0FQbopU=;
        b=vzmcv6M/RWqSnW9AteqJ8Xec1r9airLBXb2VaVzBq0cAzJ3pQEVqJ9LtCkjD6DuBUf
         mJOb6tNubWzgTfE29N7JzfBPTWdJyvji3aQIybrViRWS1U5wWt2fottIJXkFljA3LwIN
         v0v+urje4TzJj2htdHkC9/QwvzK/z7KrcfgCuO8w2AdBn1rDQZO0HpBjzKvoM9rrxM0M
         OFx+kUViK9OWF6AVo0hVsrDnn57DyzPdpxR6SshkCtZGGvvqLAt1qQjn9rVRrhacY73o
         RKBx7Oc00OW7DHo68SrVceaGnoqQtXzntOLCKr9wvel5cwPK/etM5LRqPVPHZVlwQzt4
         BLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729758049; x=1730362849;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e2kiKp4RgrfPbI2NGuX12q84a3Rc1kCYks5Y0FQbopU=;
        b=ovs1Js08R6197Cx9BeEK0EJZlHdkk786uSq4h5jBFq0P/mnxXExwhGguramF9u7zVD
         AEuhj2f7URj+JNPdeLb7sueK0yRDnbK8jEwoetFFm2/pBsOsTTOGNFS7AF4MTVd4CSw6
         dbMIBmqXUG/WBo8MSojcK/ma90NIKD+7x4cqPgZNJur0k+h4Q90wa4dQR87WlnoWq/Fi
         om8ZAMwrmWocQoYOBvLnEC82Po+8DVUjpk7N9Psup9EtvgtzD8wBbAElHIfsocvabVuI
         f3HwLqtYZDCY63r6Nvfkk69xXylcIDkjj6ZLDx5FFqWOIy5p0BMMdL0qfPnZrbXJPyrI
         VBxw==
X-Gm-Message-State: AOJu0Ywd/cMDraI6uXTiz9jTkZDculK2egBkwFNFClmTOMIJ9+jliWgY
	5qs8+MrvLWyKZRswAszIhTbseDvql7x37+h/QCH9DnV5nwpk3SfO98iKiSctia7dWB6+37T/kpe
	o
X-Google-Smtp-Source: AGHT+IEvT9dQpTZIFHUAzEIeUPyd/DpWd5v1CScFEIgzYUC5kIUWRh7H3hQKeApzCVFurxMGWx4RGw==
X-Received: by 2002:a05:6000:4598:b0:37d:46f4:35 with SMTP id ffacd0b85a97d-37efcf84a6bmr3204504f8f.45.1729758048938;
        Thu, 24 Oct 2024 01:20:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a584f7sm10703548f8f.53.2024.10.24.01.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 01:20:48 -0700 (PDT)
Date: Thu, 24 Oct 2024 11:20:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shravan Kumar Ramani <sramani@mellanox.com>
Cc: linux-edac@vger.kernel.org
Subject: [bug report] EDAC, mellanox: Add ECC support for BlueField DDR4
Message-ID: <046bf689-9a2b-4993-b8ca-927d7d2a0cc5@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Shravan Kumar Ramani,

Commit 82413e562ea6 ("EDAC, mellanox: Add ECC support for BlueField
DDR4") from Jun 25, 2019 (linux-next), leads to the following Smatch
static checker warning:

drivers/edac/bluefield_edac.c:205 bluefield_gather_report_ecc() error: uninitialized symbol 'dram_syndrom'.
drivers/edac/bluefield_edac.c:219 bluefield_gather_report_ecc() error: uninitialized symbol 'dram_additional_info'.
drivers/edac/bluefield_edac.c:231 bluefield_gather_report_ecc() error: uninitialized symbol 'edea0'.
drivers/edac/bluefield_edac.c:231 bluefield_gather_report_ecc() error: uninitialized symbol 'edea1'.
drivers/edac/bluefield_edac.c:256 bluefield_edac_check() error: uninitialized symbol 'ecc_count'.

drivers/edac/bluefield_edac.c
    173 static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
    174                                         int error_cnt,
    175                                         int is_single_ecc)
    176 {
    177         struct bluefield_edac_priv *priv = mci->pvt_info;
    178         u32 dram_additional_info, err_prank, edea0, edea1;
    179         u32 ecc_latch_select, dram_syndrom, serr, derr, syndrom;
    180         enum hw_event_mc_err_type ecc_type;
    181         u64 ecc_dimm_addr;
    182         int ecc_dimm, err;
    183 
    184         ecc_type = is_single_ecc ? HW_EVENT_ERR_CORRECTED :
    185                                    HW_EVENT_ERR_UNCORRECTED;
    186 
    187         /*
    188          * Tell the External Memory Interface to populate the relevant
    189          * registers with information about the last ECC error occurrence.
    190          */
    191         ecc_latch_select = MLXBF_ECC_LATCH_SEL__START;
    192         err = bluefield_edac_writel(priv, MLXBF_ECC_LATCH_SEL, ecc_latch_select);
    193         if (err)
    194                 dev_err(priv->dev, "ECC latch select write failed.\n");
    195 
    196         /*
    197          * Verify that the ECC reported info in the registers is of the
    198          * same type as the one asked to report. If not, just report the
    199          * error without the detailed information.
    200          */
    201         err = bluefield_edac_readl(priv, MLXBF_SYNDROM, &dram_syndrom);
    202         if (err)
    203                 dev_err(priv->dev, "DRAM syndrom read failed.\n");

If bluefield_edac_readl() fails then dram_syndrom is uninitialized.

    204 
--> 205         serr = FIELD_GET(MLXBF_SYNDROM__SERR, dram_syndrom);
    206         derr = FIELD_GET(MLXBF_SYNDROM__DERR, dram_syndrom);
    207         syndrom = FIELD_GET(MLXBF_SYNDROM__SYN, dram_syndrom);

regards,
dan carpenter

