Return-Path: <linux-edac+bounces-2630-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A799D6D1E
	for <lists+linux-edac@lfdr.de>; Sun, 24 Nov 2024 09:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F202812E0
	for <lists+linux-edac@lfdr.de>; Sun, 24 Nov 2024 08:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81D0183CBE;
	Sun, 24 Nov 2024 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzeLvblt"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5438A154430;
	Sun, 24 Nov 2024 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732437920; cv=none; b=QhoiMW02L4NWJ81+sVOUoeVs4okVGisB1D4lI5OTsNrHJy+KaqoladLz0TfRKxi9wsXs4d1Atp/RYzBhT+WSOuzdRCegA4oQFadTk1D3GP/4ol/ZTFL/LWpRRoQ1hE+bs13xwl9fAu9I6LYJ0GAnGcKZE0AO8IttTMhOOqSvpOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732437920; c=relaxed/simple;
	bh=L/B960ZUK6oFm9KX0F36Ar23lhXDaLZlEJftm6qhPso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G67IuukITvdESw6PPcI5a1XpBiF6vtni4tJaz3SV+auosBgG1JsOu4QR6gvToCcVxgp+07VVUsIqUvZTvlxA5Uo2JvSpOVzO32sGh6w0PStk4Y7MAPYB+fhR0gUnDYqzpKX7I+zOeMeYFbmb8qRDyl8NUBf2hI3q3x2zHDqKVEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzeLvblt; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ed91d2a245so1196015a91.3;
        Sun, 24 Nov 2024 00:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732437918; x=1733042718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3R9OsxCdswWtlB5Por3GdbqaxblTmykUB0v1B3P99UI=;
        b=JzeLvblt7bxF7t9Y5oRDwyv/Qp5BvoUMfouKvp+6Ly5wkzjBqVx263EdCxP9Jm1hiG
         XyAWE8lOv3yj0PSsq1EQ1bMfiaOrrWzKYIa7BKmqIZPeBUzu0/IWVQq2ywQwd4PMIQh7
         slQ5v8wUBgBtCiv2ML/iZwIm+ZjjSJ+LsXcjE6IB3+OFebDv17AxvealibRDtYElMgzN
         /6fkf/SXYIrf3XJ3Al1M0Msk6/eG1YevR0N0qcjWL3+KfgXcj9e2V79jLUzpEFzCe+99
         /OreQhxsfLM3NtIOFfMVJxB9YFmeh4HkJzoqoyyneDsmhBCWqwror1SwRe36q+yL74fi
         V9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732437918; x=1733042718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3R9OsxCdswWtlB5Por3GdbqaxblTmykUB0v1B3P99UI=;
        b=qWKk/m5wkMlZQCPKL39Y4+0O/OESpV0Miz3aOCQBJD5f39T6zpT2a/2uzw9Y69sSrm
         62LX7jsVHbM2W8xGBjEWtstQ0NQbOXWWQtv6PFVZazI5as5vUrsNaLJdTCjrgJVGHj9U
         RB119NbEn7yLCqBK9ywWNShXX6hsuN46le9vbvmEBbZuPZTUWJ4UpZ93gcghXWsZAtAE
         Cn7hqJSuoG4Zs13pdQ5M5f6aexI4iJjAEOWOr4167pXmaoSa7pqVcvsSQnTxVeI98oAf
         PHNE1aFl5psm79oC0clEuj8WXs+gYn68mG6tanLD/tgbxdR0ZXjthixnEcTXVeM5ABaL
         do7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGtUgv6xu8u3o7nxydvtnWg0BEwiWIrZzCF1Dd8f1Ydf2pq9u6O0ouZL5nAtXs3bygvRvvHzpKDZa6@vger.kernel.org, AJvYcCXj8HAM8czaL4+rgJbpcJ85/5bdQcmAhO0KIhxhTbiqeR/+WhY4q0G12cXNYlMBJ2rax4W2J6JP50SmRBs0@vger.kernel.org
X-Gm-Message-State: AOJu0YyBnjsuwvGHO10nOfREdEZxRN8Do4Mx9pQVZp5opgKgFWnIvfWi
	CqoEsZ5pWJNNHAAvdV136mYoPD8wgPlvcb6rFnJL36NrGA8zifMHYrL+VjchNEI=
X-Gm-Gg: ASbGncukXVRdOm07q8EzLYZ60tufM+3H7yp3OWq9Rx4Onz3Zi50PpvW/yW0N9W9RoFP
	/Vn/TQas5d1nFkxVYA9Ep3yhQFm8caFnym+gUyqF5dOj5sGyqhVDmnVwjgPn0Je/nGzk5XqeKAb
	jDPDtV4yaNuqg0hBuPZIKeQzgdv8yWWdAC96ZVrUqOI25NMm9Kf5IsKUWm4QEdNSFilyq4jUXvx
	aSVr/mT3AR/qASjZuRgyIi5/ga+L129XCkK72cRuVLpIScV
X-Google-Smtp-Source: AGHT+IF08mzNjuHFHUY0zKduhPc0J8Ocms15OD2nzc8IrMpNhK8aCJJY8eODgIBd6HYn+E3GsMpQ5g==
X-Received: by 2002:a17:90b:3bc5:b0:2ea:98f1:c17b with SMTP id 98e67ed59e1d1-2eb0e024bf6mr10340580a91.5.1732437918387;
        Sun, 24 Nov 2024 00:45:18 -0800 (PST)
Received: from Emma ([2401:4900:1c21:cadf:5054:ff:fe53:2787])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0d0600b2sm4454626a91.44.2024.11.24.00.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 00:45:17 -0800 (PST)
Date: Sun, 24 Nov 2024 08:45:12 +0000
From: Karan Sanghavi <karansanghvi98@gmail.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] RAS/AMD/ATL: Fix unintended sign extension issue from
 coverity
Message-ID: <4shdmryv5gq7lwc6zp5riiiaoatgfv7fji4isuhnbwvkoliiqb@uwwlt5n2juuq>
References: <20241108-coverity1593397signextension-v2-1-4acdf3968d2d@gmail.com>
 <20241112150419.GA3017802@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112150419.GA3017802@yaz-khff2.amd.com>

On Tue, Nov 12, 2024 at 10:04:19AM -0500, Yazen Ghannam wrote:
> On Fri, Nov 08, 2024 at 04:40:41PM +0000, Karan Sanghavi wrote:
> > This error is reported by coverity scan stating as
> > 
> > CID 1593397: (#1 of 1): Unintended sign extension (SIGN_EXTENSION)
> > sign_extension: Suspicious implicit sign extension: pc
> > with type u16 (16 bits, unsigned) is promoted in
> > pc << bit_shifts.pc to type int (32 bits, signed),
> > then sign-extended to type unsigned long (64 bits, unsigned).
> > If pc << bit_shifts.pc is greater than 0x7FFFFFFF,
> > the upper bits of the result will all be 1.
> > 
> > Following the code styleof the file, assigning the u16
> 
> styleof -> style of
> 
> > value to u32 variable and using it for the bit wise
> > operation, thus ensuring no unintentional sign
> > extension occurs.
> >
> 
> Please make sure you use an imperative voice here. For example, "assign
> the value...and use it...". This should read like you are giving
> commands.
> 
> > Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> 
> Overall, looks good to me.
> 
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Thanks,
> Yazen
> 
> > ---
> > Coverity  Link: 
> > https://scan7.scan.coverity.com/#/project-view/51975/11354?selectedIssue=1593397
> > ---
> > Changes in v2:
> > - Assigning pc value to temp variable before left shifting as mentioned
> >   in feedback rather then typecasting pc to u32. 
> > - Link to v1: https://lore.kernel.org/r/20241104-coverity1593397signextension-v1-1-4cfae6532140@gmail.com
> > ---
> >  drivers/ras/amd/atl/umc.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
> > index dc8aa12f63c8..3f4b1f31e14f 100644
> > --- a/drivers/ras/amd/atl/umc.c
> > +++ b/drivers/ras/amd/atl/umc.c
> > @@ -293,7 +293,8 @@ static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
> >  	}
> >  
> >  	/* PC bit */
> > -	addr |= pc << bit_shifts.pc;
> > +	temp = pc;
> > +	addr |= temp << bit_shifts.pc;
> >  
> >  	/* SID bits */
> >  	for (i = 0; i < NUM_SID_BITS; i++) {
> > 
> > ---
> > base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
> > change-id: 20241104-coverity1593397signextension-78c9b2c21d51
> > 
> > Best regards,
> > -- 
> > Karan Sanghavi <karansanghvi98@gmail.com>
> >

Dear Yazen,

I hope this email finds you well. 
I'm following up on the patch I recently submitted linked below.
https://lore.kernel.org/all/20241108-coverity1593397signextension-v2-1-4acdf3968d2d@gmail.com/

I noticed it hasn't been applied yet, and I wanted to see if there was 
anything else needed from my end. 
Please let me know if any further information or modifications are required.
I appreciate your time and feedback.  

Thank you! 

Sincerely,
Karan.

