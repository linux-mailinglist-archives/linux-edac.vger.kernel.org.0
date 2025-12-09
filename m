Return-Path: <linux-edac+bounces-5558-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 819EBCB04D5
	for <lists+linux-edac@lfdr.de>; Tue, 09 Dec 2025 15:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C21D1304A8E5
	for <lists+linux-edac@lfdr.de>; Tue,  9 Dec 2025 14:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8D42FDC52;
	Tue,  9 Dec 2025 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiuIXCJ9"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F352FD7BE
	for <linux-edac@vger.kernel.org>; Tue,  9 Dec 2025 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765291061; cv=none; b=LgovN0NohfkSbvKky8mFb562Q8m+ubWqntSLHko2NxmWKMQtjCoToy0nJHOkZRb38fVZyHUzUGg+dtjqF8+G+Ui/V0q/U1AkBkdRJ12o/YFwfO5NL/Axyc9va8cYWh313zMwj83228LQdYx2mWxvx1eOOSD62ht7GhGUMHQp9Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765291061; c=relaxed/simple;
	bh=FvGNQ93BnOKGTFRoXunqjFw6C8IGuEm1oHOP9fxSZhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTdHw+RC9k+nT/HEemUjQ9KpjpA0LY07yWxfHCQTIXbgDc043iimYPukx7QsHKd0NxarZxLpTpqjQjPkquHzPKFfh20jgO9GO1t/wy//DDPEDAiRC5LhYN869s+ye4vR4jy8xUNW68gev4VuQIgIUEt+X2qCMgcxslVlh7r0gKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XiuIXCJ9; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477563e28a3so41986315e9.1
        for <linux-edac@vger.kernel.org>; Tue, 09 Dec 2025 06:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765291058; x=1765895858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BldK9Vs6IjF0wInmk5nYkJAUfe1JnCd6MJmegFzUQbI=;
        b=XiuIXCJ9uQIAHXsulJPn5dMYLMBrLA9x0SkPX5PIWafEH2bwFEYWUEv8zfmmTlB9sd
         9LFpJG83cAdZ8dR5B2H262CEdo/iwSBxcVcpTefrqK3wnRZsj/B3PobqJcFli3GNDj1y
         ZeK9YgG+UvBRtRjRloqnNfKWKLgWR1u/xRu7uDYlPyy/WRTaU+ubs7VZNlvs7rQcjVQu
         FV/A+2CiubG2adfC49GthtEkeiQk9UD3If5gAN2ub5OfkmDDaz8c3GdznP+ysZZqXQzK
         wbaZd0iPhODZ6IpPnFq8HF8RXyom4PnbSGH9wuooG9KMKNvcJ5940y57lGm3Jy9e0D9P
         hzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765291058; x=1765895858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BldK9Vs6IjF0wInmk5nYkJAUfe1JnCd6MJmegFzUQbI=;
        b=gZ0dbZ/XnfxnN5/xsJiQRN/uVYShB/RdnuhzHVeuYfR2bXKxaVcIe0KQXDa8nXX8wA
         oGKTFRlxvTv2GPC/bRQgYP/9D5KMDqw2v0zsklvbsP4d0i16ltfptTwVJOuNKiTpq0vl
         OkO+ms5Ak0Y8qZ+hE/3ygU+3ihXF1vheiDqDsdA5NZ2IvmO+SzmhFXR9rYomPzxJxT6K
         jeflqV+uMRBXtmwzJnmsg9NRZAQMuNkDHjigy079iyACS8UcVPuwSgfmfkHDMOPcRqSm
         LMiFoYlZ9dHCh8BtqEwS/+aelGRD9CBUkdAqLqIF0XWeg583J50lwHlmIirGYYSo1bAI
         5XKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOTMJu+OkYaVj4gyItYIULNnLeYXzaDqktEslB+15a3uFAq7YqfMHzDLGK4zkqJVvmXN4L2iq6a7aO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2hQSreTqwL+KtZrDWyUOzhu2icgVoQ2c6VHhhIBslr2dfqU1q
	u2Ev/B9Pb10OAhpGv/toZn8KtKj45bgDIitvfLk9c0XlNz0J39HUEU1PcOALW5cnlH4=
X-Gm-Gg: ASbGncsNUgCi4VRhHSRPW2QNKBAxPA5pWzMBG/QnI2tEc85CcZWvM5KZAZLffnOq7g1
	RK5LBkNnDeVlKtDPLU2mpJIphkx0v9pCkOOyUvLMGSpy9PqDTxaxCNlkh4C98sLq7tSwQHM7e7g
	DJQgNe6WQEIZE+9U+qwRKqpGp8vnMFIqwQDKigLJ6SyPL7yMmKF5ioHqjMMyuU5AOv3+v+6C+Dk
	gGnPXWl1fa6xam5dte0jlhobU1X3YRTSWweSCeKvPiJLTXQXo5LDwdt9mTBKrLvpCarCkzsD4Im
	ICXYvzZy+ZncZMZ20xIAdsOLrLFlL0le+ySPcgyjkYlsa3vQ2rVT9rqN4eLjMSJPQzAwwf7LtPK
	6YwrnYeTc5ADT4pbV3MOindQEzTe0uPlGnRoqnLGxhdHIM6xfNN4kT8Af6EtiCFwU8R7mTJ3765
	kRWaR2LbnB+3nAVkR1
X-Google-Smtp-Source: AGHT+IGgI4wHvC+9WKvHMH7aD7uf0OW61Hf4TKPveUTQeZQVMn9uixyJZ3HP6SThVBqnKYajIH9pQQ==
X-Received: by 2002:a05:600c:6d54:b0:477:991c:a17c with SMTP id 5b1f17b1804b1-47a7f9190e1mr15368165e9.6.1765291057926;
        Tue, 09 Dec 2025 06:37:37 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7d367dfbsm21472605e9.2.2025.12.09.06.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 06:37:37 -0800 (PST)
Date: Tue, 9 Dec 2025 17:37:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>,
	Aristeu Rozanski <arozansk@redhat.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] EDAC: fix a limit calculation in calculate_dimm_size()
Message-ID: <aTg0Lsj_3bMrsrt9@stanley.mountain>
References: <aTK9mKTphPwuR7qb@stanley.mountain>
 <CY8PR11MB713404B614F5D046E94DE2A289A7A@CY8PR11MB7134.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR11MB713404B614F5D046E94DE2A289A7A@CY8PR11MB7134.namprd11.prod.outlook.com>

Thanks for the review.  All good points.  I have resent the patch.

regards,
dan carpenter


