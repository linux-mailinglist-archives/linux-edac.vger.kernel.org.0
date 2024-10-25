Return-Path: <linux-edac+bounces-2279-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9FF9AFAA1
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 09:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7D1285FEC
	for <lists+linux-edac@lfdr.de>; Fri, 25 Oct 2024 07:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58211B392F;
	Fri, 25 Oct 2024 07:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YIBuuPv5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F1F67A0D
	for <linux-edac@vger.kernel.org>; Fri, 25 Oct 2024 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729840122; cv=none; b=BZrakNYWJnKdwEdpQXXwhxWSTeDqVevSZpaSMEtzSx5ILgpes0mAOXRM0MwruIJES6fmeVDcRjHljZJSASRdYLVzmeVYOi3AZydkFshjy1HWkY1+lrieUhA+wJOLAtQqk8HpNBbx+/x1fq9vy0UP295riCmrx97dZewQ2/aIGRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729840122; c=relaxed/simple;
	bh=JRmgeIfgxiaJglBf348zcoInp8TPx5Pje2Z/1h2y5GE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j0N1uT/OTMxyr7krcj6JAkRHZYR2FhqmoUxLAeXaptedKMNYR8QADLx7VJOTFj6+emquZH5QUvHyDfRbNuGbnchiVyzRYrqAqloktveFZBLdo+yK0yJYNdTTvzyzuCsDI9rNKLs4L/AjYSSelT3S/WTY+qQg7vVKlYrjaf9NAgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YIBuuPv5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43152b79d25so16150025e9.1
        for <linux-edac@vger.kernel.org>; Fri, 25 Oct 2024 00:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729840118; x=1730444918; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o8QIRJXZ0+XZEDeR8/B5YrJvK8bXfy8avEI3faauU9o=;
        b=YIBuuPv5kvU/W49WWx3Jv5KLLBMZbO971zhLCr2blTNj/xxTj/82YkFLY4zaAkztB2
         ShkXwbJdXEi2W6SwZNtVOpNF3kKQs8BitfmP1iR4IJnjtPyo5a8ApG/FWa5m+/jFnE3r
         1w1Xq6B2PDsr4UXB6pyFzIRavm3Cm0ID5X6gM+yvTZrMPwEBhsEwwYjsxOaSL5dCp7hb
         LnAJwb8gkFtodXX/cc2SzpUEfXZnvHJEFGqehTSalFmlZ1rryyZDkX4SyJWaztfbYxuV
         HAZR2IzPuo/lI0oumldKLkG0cQLaR0zXVXaRFMnS21ezHpzMuhheoX4TXmwMNx3MKjul
         ihQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729840118; x=1730444918;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o8QIRJXZ0+XZEDeR8/B5YrJvK8bXfy8avEI3faauU9o=;
        b=YFG05n2vvTupAkfOk7dkwOyAwjrUTxmLZVBK63wYLu4qjZ6SN0nkX5rA8Vu4IgSQVZ
         nzq/QBsCoZxW1Iy5Y2ST7FQ7fbnLp8APyPxWeuqOpqX9VpbXGyGk1s1aibdXZBTYMN/t
         akB97zrSHWg4vxC93Min6/z4DW6OM5EOpZX49JBoi8/McVqdZOviHeqTkeZJGfw8PDQR
         4FeGYqM/CVwBWqoSJT8NhYA2b5C1qCkxx4qsY0dXHXfOc4zpS6RkXma8E7Gnv/Z5jEBR
         qm2uQIKqvb1zHNr7UTRq/uCQql+io9rOMT/nZs6j0D6egj2uByRoD8DDgMb4eSLNTKWG
         wqDw==
X-Forwarded-Encrypted: i=1; AJvYcCVU1DqfUq0L/Kqh1LIFC0mhd43xICaM/4f3lW3XqLa6QLJEKPbSzQVuhipihabycGQ898I2AamX6sF8@vger.kernel.org
X-Gm-Message-State: AOJu0YxYdEoMUZA3rOVbmYXxVvf35fcG+TRjq3oSvms/E//Ug5fUxsrY
	FBSOH0AFVE7jtIArgQom0ENJKl182hpN6Hxzhg55o9HqW6VEHyBc0Fu/DH+A4WDzKdfgZe3u1Nv
	xsGVvOQ==
X-Google-Smtp-Source: AGHT+IEp2xGh5PqBWDM9Wkg+jeApGvA2cMBwWIOZECFXOmPjkiTnjE1h24IkOrL/WyXpO+gZkhUe8w==
X-Received: by 2002:a05:600c:3544:b0:431:6060:8b16 with SMTP id 5b1f17b1804b1-431841a3434mr70696715e9.30.1729840118259;
        Fri, 25 Oct 2024 00:08:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b56fbd1sm39546115e9.32.2024.10.25.00.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 00:08:37 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:08:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] RAS/AMD/FMPM: Remove some dead code
Message-ID: <6b914abf-b3ce-4baa-b4d7-f8da9a840a3f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Debugfs functions don't return NULL, they return error pointers.  Debugfs
functions are slightly unusual because they're not supposed to be checked
for errors in the normal case.  Delete these checks.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/ras/amd/fmpm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ras/amd/fmpm.c b/drivers/ras/amd/fmpm.c
index 90de737fbc90..3cde1fe17a7a 100644
--- a/drivers/ras/amd/fmpm.c
+++ b/drivers/ras/amd/fmpm.c
@@ -956,12 +956,7 @@ static void setup_debugfs(void)
 		return;
 
 	fmpm_dfs_dir = debugfs_create_dir("fmpm", dfs);
-	if (!fmpm_dfs_dir)
-		return;
-
 	fmpm_dfs_entries = debugfs_create_file("entries", 0400, fmpm_dfs_dir, NULL, &fmpm_fops);
-	if (!fmpm_dfs_entries)
-		debugfs_remove(fmpm_dfs_dir);
 }
 
 static const struct x86_cpu_id fmpm_cpuids[] = {
-- 
2.45.2


