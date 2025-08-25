Return-Path: <linux-edac+bounces-4651-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFC8B33E5B
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 13:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7135E7A88CC
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 11:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B84926A087;
	Mon, 25 Aug 2025 11:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgwRbjjy"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D815266B64;
	Mon, 25 Aug 2025 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756122636; cv=none; b=ZD5VX7BwijpYCnDLxMa8+OPZJtmSI1nNB/JJ9AQe6toaVi7oshdtrlz4Er5h4/tpZZ5Tg8/jUQkC5dVIgpT+My24aWW2S88b/yGXuO+zHmiU23ox7kda3Tx90fw+ZrnDmV9Ym4PO7XcVlOqQSBpV2CPZd90YdRck4Aq219E+KuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756122636; c=relaxed/simple;
	bh=eCe1x2eM/h5u/XvPOFvQzDlVvyRIBygm9B5IZS87qFk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Asg6V+M7/rBaeg8t+phD5R6gKDpufIsIlaEHSJC42E2FXCwPkrHL+CtKbqwNQjfHtzY+61TvzkhVRIUaf01HIcHIo2tzhBSUCS9EzRRzQY239LM4RwWe2CIoTjgo3F52J3GwFRjUPT4sSkoMEvBdRHHOjMasDeYlwEPM9Qpueew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgwRbjjy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b4d892175so20126585e9.2;
        Mon, 25 Aug 2025 04:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756122633; x=1756727433; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hxh4FYezlJDp7aIHU9Q4cLSDh/IutPb4uKP08oUsDqE=;
        b=AgwRbjjyk4qB6E8YQ8eE05Ev1oI7PHRVMSucF6SJfOwf5QJzsOLbgxHwi8ufCxbw0d
         mE9eCS5Ko2kKGWxnb75dk3iCtmA6ZKfMh20A6nPidpt7FJLXKMS3pM0iCMF+iB+zpq24
         wzIErK6T4J0WJW79BCsheFgaMl6AGOQLZ1pRR22FfYyroSMdK+SECBtdYWPXHkRz2lAA
         kAey3lubGZbqoPj2v4JBWu2PzFeft26eLHwB4Ft7OcG9wcCiSry9Xgk8SJTdhB1spciS
         dMtTIrxQLmjFjeZmXZ+Pm/DbaBBL2PmzsFE/Bl5G3YsNYgVcZ/ogOucY5E9GsnWT6O1N
         QbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756122633; x=1756727433;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hxh4FYezlJDp7aIHU9Q4cLSDh/IutPb4uKP08oUsDqE=;
        b=plGg0zsinhR9MDuuvdVkTjpO474Eud5HRP+7iy7EA3wQuqBFjpFM5K6GWtJRmmFJFD
         rSeUZ/fRHY67F4C3bWXIfYbO5nNCXeqjATaeLjbDxMnJ3GB8JfdkuoLJGtEdIet0Lmlk
         coQDTKJ3UTOb7RJ9ne5oUE+UAz+SJXXGHRxQqMtk69XRL8KmfFBs99DouiJu6czN5BT6
         u8qUqWzmJf7unY+qqWgBuJ+6Cw+1HOL70UEu2qwofR2nq2y8vqCzvCLRH6dS6/BXAubq
         ndjOxHgTU/gFWvCbSulblXzWXZWsoSgkttfONNNQx5q51biIxBfqdd96j9gTjtExwy18
         IqRw==
X-Forwarded-Encrypted: i=1; AJvYcCWryyAMaTHFXrariqx36aLauSkDVxcu3I0IXgtMePgAPtonKwWNk18IN8St4p6u4KfpjGCO8XUw5abgEygI@vger.kernel.org, AJvYcCXEY+rgc07mNXXZPCJPjkHmwRZzMfv9W2GdrXdCwRLd7rwWWXgbHtwkwsSqkDfiP8l0hr4ngiMvgWpC@vger.kernel.org
X-Gm-Message-State: AOJu0YwwB4yODf3EMVay7jJlAP+zQZVVaq+QOHA5Ha3/eDi403yLa5FU
	sP16QgZuzc/QRHkdMMcjdfSgLDAChNuNrEUztbi+ZDmExYOsjxMHqTJX
X-Gm-Gg: ASbGnctEaStTUcDu5Eqz5CTEd2hcumi/l05R8irVTwUj7m03KqfpWX5QTsKHXDABCK/
	Lr26CsrhRZ1q/zsB1ikbjox+PD4ZjFU4TC9k4Wros3qxfvnhWfQ4DS/QdPD/Am5iyoOtD+UiNbI
	RS3PRF9gYOLQqzVmrQEVnzyKyjsCa3as9Ohbu9yny36w5NPpem8ig7lE+UgEG0+vEllWF+D7Nrc
	YLtoJPVnn1Ba+TRe6l0Vs9nXlWwJHz9VP/hDbeBNcmlE8IbMKGY9YkyUH49J5Byu2P26M6DjvlB
	lCU4miUQh/SMWDBUrFMe4xMGdtR0UPchZeEMb0TVLjHPeRQzkmG1HYie4cmesiQ9Ntkq5jQkPY+
	hH48foGhBgN73
X-Google-Smtp-Source: AGHT+IGbBKeMht687ePvnDzDvaX1UbSnFE+FTuf4cyJWHs8sXevz53TXFn3BjSEhIlTpWJp8L+Wz5g==
X-Received: by 2002:a05:600c:630c:b0:456:2b4d:d752 with SMTP id 5b1f17b1804b1-45b517cfe7dmr89539095e9.20.1756122632536;
        Mon, 25 Aug 2025 04:50:32 -0700 (PDT)
Received: from pc ([196.235.191.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5b10sm11229046f8f.47.2025.08.25.04.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 04:50:32 -0700 (PDT)
Date: Mon, 25 Aug 2025 12:50:29 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Dinh Nguyen <dinguyen@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Markus.Elfring@web.de, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH v2] EDAC: altera: Delete an inappropriate dma_free_coherent()
 call in altr_sdr_mc_err_inject_write()
Message-ID: <aKxOBTzpu1h3aGIw@pc>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

`dma_free_coherent()` must only be called if the corresponding
`dma_alloc_coherent()` call has succeeded. Calling it when the allocation
fails leads to undefined behavior, so remove it.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
Fixes: 71bcada88b0f3 ("edac: altera: Add Altera SDRAM EDAC support")
Cc: Markus Elfring <Markus.Elfring@web.de>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Robert Richter <rric@kernel.org>
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Acked-by: Dinh Nguyen <dinguyen@kernel.org>
---
Changes in v2:
   - Improve commit message, as suggested by Markus Elfring.
   - Add Acked-by: Dinh Nguyen <dinguyen@kernel.org>

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


