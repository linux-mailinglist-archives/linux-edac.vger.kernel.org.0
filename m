Return-Path: <linux-edac+bounces-4422-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAE5B0FD2C
	for <lists+linux-edac@lfdr.de>; Thu, 24 Jul 2025 01:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30FEF7A6293
	for <lists+linux-edac@lfdr.de>; Wed, 23 Jul 2025 23:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07DD1FE44B;
	Wed, 23 Jul 2025 23:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwJlw+Cc"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C51282F5;
	Wed, 23 Jul 2025 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753311810; cv=none; b=JLVU11bQOCB56zKypJ5oKMzfTZ4KMLNKxHM4yjSSrK491emGMPAMsz9TfIA0mv9D2jqJj24n7Vkfdgxgi3IXT1uh/lZHYHMTgcfIfogruKNaKz2eIowYcvK5WWtQmQelKuhlSeiyxGFMHcTulnjU6SGouYJgETv7hMORe14W4BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753311810; c=relaxed/simple;
	bh=oP3hbDnt+bo/EZXFJrv6E4zO9605XJ0tyVj1D8+UrwE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qaqzonRVrEyp4HT8bpXu2xD55yDxaolNScqCCpUaKMjuK/SCRXJFsKPHAg16GErJu/3L9bkFQuNjr2CNOEXXW/OZKn8gTMqF86owZAR/VlBWWl1Xa45iT0PuMGyX9dtt8kxR7YNukcGXHvGux6BaNKGcGv6S40Ei57eXtRZbzCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwJlw+Cc; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fadb9a0325so3110016d6.2;
        Wed, 23 Jul 2025 16:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753311808; x=1753916608; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ZspM4JB45nGmSnHCgOmvTD5hIvgHFsAOUCneY3O4CA=;
        b=OwJlw+CcrmJVKjYoMwmO2b2+oK3oQWis5WGbXbOl3jc3ksy7Xa+CjN5ux1vVykyxDL
         cMq+cZVgzs69GXbizJinLUP1rw93sE7H/bkZtxMpmp8EJGVIG1vAkkVNlLyFWKH3koYr
         M+jjfgsTquvvFXSgK343SQjhaRW2e2I5mu7BulymFryLQhg2YjkppP0zgIpI1apejpvg
         BBHrxrjgezh1R48uinGpwhZ2duYFJkqo+Qr9WmELPSR8NRnr1hYClOSA6ZLT+Zf9U8B8
         AlbBp+lMZht35LO9bvk5idXqB5VyMEGoQj7TXfiZwWU/pNB3RQdcMvZJgwkZpPRoA9Av
         PuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753311808; x=1753916608;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZspM4JB45nGmSnHCgOmvTD5hIvgHFsAOUCneY3O4CA=;
        b=vKFUsYCw9Uy5oGi1y3EYrLvrhWj4GMe8RZqjGb2fTkpRlO5w+JvcQdXzByDl/2Muo5
         Yw81Q8iD5uIhGBDG1gLE2heXLNkmgSCXaSvCgCcXKYcXXlkGlUJx6YqgXhguW9boSJMQ
         rQF5GrPYSED6qH6qyTFUEov4htmHlT1pJHZTIvSniD6BstoCox3sB8RPYPJmJnmElFmB
         YPzAgnt/ROuq58KLaq1bBnYQ2QYwWHPuC0WS+8SMq6KiWm1s9reOEammFdu5P3WA3mMn
         jrmoLmR2Lp2toZsX3NVUe/WiOmlj6cI8+uYQG59ZNbbHzgHM4e0WIHdmWpabS5V3w55D
         p0tg==
X-Forwarded-Encrypted: i=1; AJvYcCWiZqgJGrfTPQsxtmaKwqHoDooE730JTAKlV/RH9TRNRAXIxenZUlIAe9W/Xi7gaoTomJlW++mhd+mV@vger.kernel.org, AJvYcCXoDcgRn3IzuCdOSnZMAp/oPBx3qqENSsJTtjTAC5gWtZwzuPdANgN2/PpnYeNj+G/ePOfFncxZSEkxOCdB@vger.kernel.org
X-Gm-Message-State: AOJu0YyYQKtQh+mwBasyzURQw+TXHSmTrTsTEXy5p6qbgh7derICV19S
	luyQw/5mSKnYRSxy7RD0flbmvjny7TOM3AhG37eqAnljqFrnlGfPIhmG
X-Gm-Gg: ASbGncsDCkR/HymDSiZPWMTDwOLvoYRXFSq/SjuFgnsbHSkq/tZ5DDVbgxNO7XdOK07
	9xuqrj68phLWfyJ1KKEt7PZhq0XQRlHWLK+WNMCmJW8RmcEfDbWeJpNX34HAbHB8fUXPP+lb6Lz
	yoZtSe+zom7+N72kkL+E8ckC+V0B5fUIjeALyEXsFtALFVstMxkRlJ3JV76QlfIPP7vt9QtFF9n
	PwKMxyeN4EfqEykuEUBFaHuMuDMOhw1bzJ1ccNOFLHjV7ZVn3VUhjMOaZ8me/uIcm0QGzglLgvf
	3xJD0e1fpDSxVipxU5tJDL1h+8vBW5VmjrtjhHohl0/KxGH7A2T+NXkjJ5A0ty9VjtUpKHU2UY7
	GrMy7oENqhQ==
X-Google-Smtp-Source: AGHT+IFeHXBQ/lIE9f701AYOMEh9DXoBeOfhIlUD/BR1qpmuF7NyMmTt45fwm10ACw3ofMdEJEJCHg==
X-Received: by 2002:ad4:5b87:0:b0:6fd:37c0:2c74 with SMTP id 6a1803df08f44-707006ed73amr60284536d6.11.1753311807943;
        Wed, 23 Jul 2025 16:03:27 -0700 (PDT)
Received: from pc ([165.51.88.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7070faee3b1sm3160516d6.13.2025.07.23.16.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:03:27 -0700 (PDT)
Date: Thu, 24 Jul 2025 00:03:23 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH] EDAC: altera: Delete dma_free_coherent()
Message-ID: <aIFqOz2bKFXIumM0@pc>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

dma_free_coherent() need to be called only when dma_alloc_coherent()
succeed.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/edac/altera_edac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index cae52c654a15..7685a8550d4b 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -128,7 +128,6 @@ static ssize_t altr_sdr_mc_err_inject_write(struct file *file,
 
 	ptemp = dma_alloc_coherent(mci->pdev, 16, &dma_handle, GFP_KERNEL);
 	if (!ptemp) {
-		dma_free_coherent(mci->pdev, 16, ptemp, dma_handle);
 		edac_printk(KERN_ERR, EDAC_MC,
 			    "Inject: Buffer Allocation error\n");
 		return -ENOMEM;
-- 
2.43.0


