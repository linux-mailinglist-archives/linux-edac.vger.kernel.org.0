Return-Path: <linux-edac+bounces-3660-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C80A9833C
	for <lists+linux-edac@lfdr.de>; Wed, 23 Apr 2025 10:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9F6442BAE
	for <lists+linux-edac@lfdr.de>; Wed, 23 Apr 2025 08:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF9926F457;
	Wed, 23 Apr 2025 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qemb1e7t"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5358B26F465
	for <linux-edac@vger.kernel.org>; Wed, 23 Apr 2025 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396184; cv=none; b=u+CMGveg+89+gbX1bua7rYizMJLSnVn2hwt0Qq0EoNdtOSM4Z08ehjiWvI6WvEEyw9h+si3r34FGBubCHyjDim7k1fpgMBt4WSvbABINyV5OF2MZxH908YXWY2gD3UJxOErrxTlEw+e/7OqiNG4mVGJOT3M0/Si37tlj030mZ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396184; c=relaxed/simple;
	bh=YlGuSmCDbti2wP84CJBprlVPBZeKeZAImzUQxNtecjc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=isFZVG5U1mDB50bdXJuPn8oq4Wqvcnm+2IlM8cukVc3LncgBVyyLPowPqgkM0ZA3PO5z0pfBAvq6LYPXcRYO/5XZONjBAON1T1Sn6pLQDHedTUWJr9Vrstss5RvdhGe0k8Xmob5LHJmWoLR49OiAPLR5thRuN9FgvnoMzd3D2LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qemb1e7t; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39ac8e7688aso3795704f8f.2
        for <linux-edac@vger.kernel.org>; Wed, 23 Apr 2025 01:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745396180; x=1746000980; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oMA2vNLtcJxyl60Ss9Fff8F9aa1Xx+Hj04dCN9yYi74=;
        b=qemb1e7tbxLDCqiXjUExYojXJ++2VKD0uXekc94l0Y2RXifO3ZG93TzKrHQp6UFwmz
         LasMHR97dBS1iEvsuvKpVcLdSxgVIsRlIWqyjfl2+Fm2GkpdiSr/nMrn7xHDXPIWGPmy
         TovIE86ETlnq+KaKwYZzGsyKVX0pTkyjjQ0a3B/kN7fHYXCYjv1N7jP3Zl3YXIsfg/BE
         xzaF7nBkn1cZRsnfeu2YHrqWEAymfF/t78d/n5F88CnBERYZGZ4g3rmTFEbCoE4EdN8b
         L3NskJmTxs3P8Fjq8eW9SVhisvnETHVUVzfXDH6v58PMF0TNbNIQYStyanOGKiFoLhi5
         ubnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745396180; x=1746000980;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMA2vNLtcJxyl60Ss9Fff8F9aa1Xx+Hj04dCN9yYi74=;
        b=qfxL/XNPXybqoEpDYZzKEVvnbJRxqPTnLTvJUXlPyKJQjKnjvqaCXorhrBCzmDYvUY
         FsvYWpbbIJkf0rK7q4WuGr8Bl+zZ4g8k4JnEcWp/OmVHLoVBAyHQnQ1lK5FV4rqnOyU6
         X8LT5G7FrFB4a3Bn76vpjelRB8pMzXeCVRANU+qIzxgT+jC17fuxohyURK/FD0CjA/5+
         X4BSb7cf7CuGWCf+XnM5f4DvchsymRa2RkOVsTbXjVLYPyULcPp998TOXQbxHNRHfwGW
         VimmYUJ0+NLyRdhKIKe7BPNtDmYHCsD5rfeecFWDIsqsVEtg18EFch1KRWIHzLRH9u5x
         nZSQ==
X-Gm-Message-State: AOJu0YwKaZBVKVt1zpghJMbJeeeZOI3S4F/ATzV/QKtPF27FpEsycoby
	aGBsnQ8TMC0v6KIo3QG+pl9lAtg+Ugfz08T2ySHquxnLGolIRE8dqTkmDLZLQGZK3BJa2pGaiIk
	h
X-Gm-Gg: ASbGnctfrRduI02c3fTtfJZMWN7kb4DPSO9l7C8R0/VrCfXgjMGibCHgMrOVd7fW5yf
	8TH18SbcdUbGuWZkckAgIF/rvLoVEQMgOrXVp+0FaPTGL7kELQkJ+krEIoGTg+Lmp4nTpXxNysF
	/zswANVkvtDE3H6hNZVHmSQ753mynFz1h6EOjdzBGWD+W/sSGY+dkE6KP/G1kBN+stUvgoJaKw4
	QyOKTmQ//+C8C+Zp3uOgDbUEWDYMkqKY3z/hdzoqERn79wbVu/ftSTJiWI7XcY+KDqpUO1nF+ai
	n04O7hPIX9RAPZ9BkYkO0MF14Rz2tdmPNLqrZrNNEV2D2A==
X-Google-Smtp-Source: AGHT+IGrYfjOWLyZInIn/TSHRQMxa5z35z9uGU/JUIyh46z8BFlINHyE7T5IeWm2T2150yWctnzQCA==
X-Received: by 2002:a05:6000:400e:b0:39d:724f:a8f1 with SMTP id ffacd0b85a97d-39efba261b5mr15883081f8f.10.1745396180603;
        Wed, 23 Apr 2025 01:16:20 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39efa493212sm18063790f8f.66.2025.04.23.01.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:16:20 -0700 (PDT)
Date: Wed, 23 Apr 2025 11:16:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: linux-edac@vger.kernel.org
Subject: [bug report] EDAC/{skx_common,i10nm}: Refactor
 show_retry_rd_err_log()
Message-ID: <aAih0KmEVq7ch6v2@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Qiuxu Zhuo,

Commit 126168fa2c3e ("EDAC/{skx_common,i10nm}: Refactor
show_retry_rd_err_log()") from Apr 17, 2025 (linux-next), leads to
the following Smatch static checker warning:

	drivers/edac/i10nm_base.c:364 show_retry_rd_err_log()
	warn: should bitwise negate be 'ullong'?

drivers/edac/i10nm_base.c
    325 static void show_retry_rd_err_log(struct decoded_addr *res, char *msg,
    326                                   int len, bool scrub_err)
    327 {
    328         int i, j, n, ch = res->channel, pch = res->cs & 1;
    329         struct skx_imc *imc = &res->dev->imc[res->imc];
    330         u32 offset, status_mask;

status_mask is u32.

    331         struct reg_rrl *rrl;
    332         u64 log, corr;

log is a u64.

    333         bool scrub;
    334         u8 width;
    335 
    336         if (!imc->mbase)
    337                 return;
    338 
    339         rrl = imc->hbm_mc ? res_cfg->reg_rrl_hbm[pch] : res_cfg->reg_rrl_ddr;
    340 
    341         if (!rrl)
    342                 return;
    343 
    344         status_mask = rrl->over_mask | rrl->uc_mask | rrl->v_mask;
    345 
    346         n = snprintf(msg, len, " retry_rd_err_log[");
    347         for (i = 0; i < rrl->set_num; i++) {
    348                 scrub = (rrl->modes[i] == FRE_SCRUB || rrl->modes[i] == LRE_SCRUB);
    349                 if (scrub_err != scrub)
    350                         continue;
    351 
    352                 for (j = 0; j < rrl->reg_num && len - n > 0; j++) {
    353                         offset = rrl->offsets[i][j];
    354                         width = rrl->widths[j];
    355                         log = read_imc_reg(imc, ch, offset, width);
    356 
    357                         if (width == 4)
    358                                 n += snprintf(msg + n, len - n, "%.8llx ", log);
    359                         else
    360                                 n += snprintf(msg + n, len - n, "%.16llx ", log);
    361 
    362                         /* Clear RRL status if RRL in Linux control mode. */
    363                         if (retry_rd_err_log == 2 && !j && (log & status_mask))
--> 364                                 write_imc_reg(imc, ch, offset, width, log & ~status_mask);

This will clear the high 32 bits of log.

    365                 }
    366         }
    367 
    368         /* Move back one space. */
    369         n--;
    370         n += snprintf(msg + n, len - n, "]");
    371 
    372         if (len - n > 0) {
    373                 n += snprintf(msg + n, len - n, " correrrcnt[");
    374                 for (i = 0; i < rrl->cecnt_num && len - n > 0; i++) {
    375                         offset = rrl->cecnt_offsets[i];
    376                         width = rrl->cecnt_widths[i];
    377                         corr = read_imc_reg(imc, ch, offset, width);
    378 
    379                         /* CPUs {ICX,SPR} encode two counters per 4-byte CORRERRCNT register. */
    380                         if (res_cfg->type <= SPR) {
    381                                 n += snprintf(msg + n, len - n, "%.4llx %.4llx ",
    382                                               corr & 0xffff, corr >> 16);
    383                         } else {
    384                         /* CPUs {GNR} encode one counter per CORRERRCNT register. */
    385                                 if (width == 4)
    386                                         n += snprintf(msg + n, len - n, "%.8llx ", corr);
    387                                 else
    388                                         n += snprintf(msg + n, len - n, "%.16llx ", corr);
    389                         }
    390                 }
    391 
    392                 /* Move back one space. */
    393                 n--;
    394                 n += snprintf(msg + n, len - n, "]");
    395         }
    396 }

regards,
dan carpenter

