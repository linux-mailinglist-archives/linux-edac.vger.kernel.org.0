Return-Path: <linux-edac+bounces-3683-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 330EDA995BD
	for <lists+linux-edac@lfdr.de>; Wed, 23 Apr 2025 18:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45B51188B926
	for <lists+linux-edac@lfdr.de>; Wed, 23 Apr 2025 16:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9386289342;
	Wed, 23 Apr 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="im0Ha/Jr"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C02288CBC
	for <linux-edac@vger.kernel.org>; Wed, 23 Apr 2025 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426992; cv=none; b=PCv4WCtKq2wZ6BdPBmSRasgGpjjeo0c6IX3Cb9TydEyN9846ilivMCicN0a1Y+1bBu6OFK1PVS+NkfUQ3eGWMYdv/ugV3l8DEHYhPT7gCeEllUeKMNMbsmUpgaYh4gaiTMUAnXYb8RnCV520hCbO+lrVLLznQxBcJFQaV0Ke0s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426992; c=relaxed/simple;
	bh=AaJW6oZj7uAa8i6ILtNhohhVixxZynWRyR9f+oaDWlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwB7Vf+x/sPliOrezvM9ZXqw8yW0k5hRprUTzKpP6irvQca1E2B6SiKkKYphvUr0bbWHAYx4upOERP6tD/ZNgsaWRDDcupScDaKr4+gkJ+ZXDKJuAcfy9EZm43DsxqyFt+uMyvBEyZ+OB35Kdij6J7Nig3V4vPcgA/NHRJqGEJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=im0Ha/Jr; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39bf44be22fso46622f8f.0
        for <linux-edac@vger.kernel.org>; Wed, 23 Apr 2025 09:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745426989; x=1746031789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d13RLXbPFS/6DcGoCdNLJfMaNzP5WD2uKgALut8qrnY=;
        b=im0Ha/Jri64dPb8kpSDsZJw5QKqcGa22gIo5G8y0XjFD14xz7FNnlSEc0d5jLzggxd
         PpBFXEba1Q+yie6qVL3V3VDrHUUkY7VHbG8YQ0sV3mvMwoEV60KmCV/68trc0w7VB6sP
         52wSdVY+iKrLE8zOuisJDasgLQnWLFH+kgnYsAx0h+Jonjuqe+sif0fEUMIO9KCXO4A7
         GvbICkpN2Eu6MF/NKUfs8BhZtdbb0dzsXYtCTWRy9oHK91yj/vtCyM/ZroU6eRR2FXRa
         yMemlPC9zjJWsWsrE2zbdtNZSPRjm7tKR5lYrd4+1EernIJDxcDMm5Z2U8F5uHO5BZVw
         Wm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745426989; x=1746031789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d13RLXbPFS/6DcGoCdNLJfMaNzP5WD2uKgALut8qrnY=;
        b=owjjxnTYMAu8VqZDf0Trz8dzoY1cRH01EK5AKN3TzlAThvKTVzBbKatwRvmls9SwAm
         Fp8r1isQGiYzdFAzAjocjEzd3QAnKc6doT9k+qoJs9KbRzy514quYSobJPeCciuA9Wsn
         0m4TeD74c2lzU3/Afpk8AZgCaD/AWNOMevDgO6bi7DxaXWxIIBQlOeP1Od2bjGlJpyCC
         iHA66ASbEHl1cqSEa+kPtPlQ+n/H1RWwP72338+8/E38GcUfjfG+yBGib0cN62rYO0LO
         Meqslb8j8xpVLHN8kUgcDvMCLn9ZjJYI46NwMySf37gQIXx93eSLDViHWfK+9emdQ0Ij
         /XTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnKfya9tyWC2r/fOUGa+txxEyZ8Lc+gfJtAdCmbMA7WbmA6kf4Vf1aBl30ZXZOyDiLc2lUx9YjU33W@vger.kernel.org
X-Gm-Message-State: AOJu0YyU+RviEq0pyLi1qjZUOsYVGKHTK2WLdLdv8klL+AlEykRsTKFM
	uwPIMe22O9JbDJag8epkLZUHBP4eRsEpu2FEe6SDU2D2QxMDRnHFfpsRcuAW3qbigyPz6asff68
	i
X-Gm-Gg: ASbGncty2GAy7wgg4PMLV8EUb5Pws9eJRJtWHOQTOmtpekYfj0t87eWyuPfGPgWOqDr
	Mba71YEcaUgCEzjFqchnrG0eVUuHJK8mw3XJp1jD90zhTLkbXA841CmL6qZ0fr2Z79wl2ONncml
	gWgHBMYhCqrMJaeCdUt7fjIRGsn213D53/eifxi+X0P7Ey+a+TuCbHFMCgoeE0cgFlQJHDQtpI8
	mUp+MN3Pr8rx4HA6D0ry5vgUSt/w2dZp/QyoIXVa57w9rUp8ki0i9ciQS4lqFKnWjRtLWCzYFvF
	G+Ew88vIc70511o3G5O3QPwqbLaMUw/lwGD5PX4y7TYBuruJ+kcQwG+S
X-Google-Smtp-Source: AGHT+IElulydR2z4r0tqf6Ma9PoBW4CLBbvBBZ3hMURzGdVDB6yekLE5lWVATbFtTsLy3adeVroPHQ==
X-Received: by 2002:a05:6000:4212:b0:39c:1f02:449f with SMTP id ffacd0b85a97d-3a06c3fe4a1mr291942f8f.2.1745426989186;
        Wed, 23 Apr 2025 09:49:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-44092d3e6c2sm31289045e9.33.2025.04.23.09.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 09:49:48 -0700 (PDT)
Date: Wed, 23 Apr 2025 19:49:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [bug report] EDAC/{skx_common,i10nm}: Refactor
 show_retry_rd_err_log()
Message-ID: <a9ab50ec-56e3-47dd-9ecd-333fbb1d964b@stanley.mountain>
References: <aAih0KmEVq7ch6v2@stanley.mountain>
 <CY8PR11MB7134CE0CA414F81958EB5CEA89BA2@CY8PR11MB7134.namprd11.prod.outlook.com>
 <DS7PR11MB6077471F9B1B3221DA9FDEE5FCBA2@DS7PR11MB6077.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS7PR11MB6077471F9B1B3221DA9FDEE5FCBA2@DS7PR11MB6077.namprd11.prod.outlook.com>

On Wed, Apr 23, 2025 at 04:26:21PM +0000, Luck, Tony wrote:
> > >     362                         /* Clear RRL status if RRL in Linux control mode. */
> > >     363                         if (retry_rd_err_log == 2 && !j && (log & status_mask))
> > > --> 364                                 write_imc_reg(imc, ch, offset, width, log &
> > > ~status_mask);
> > >
> > > This will clear the high 32 bits of log.
> >
> > It's OK to clear the high 32 bits of 'log', as we only write the low 32 bits of 'log' to
> > the 1st RRL register, which is a u32 type.
> >
> > To improve code sanity, it might be worthwhile to create a patch that changes
> > 'status_mask' to a u64 type. @Luck, Tony, should I create a fix patch on top of the
> > current patch series to fix this warning?
> 
> Qiuxu,
> 
> Yes. Write a patch for this and give a Reported-by: credit to Dan.
> 

Thanks.  But mention what you said that it's a false positive.

It's hard to silence a warning like this in Smatch because you'd need to
read into the write_imc_reg() to see that only 4 byte widths are
supported.

regards,
dan carpenter


