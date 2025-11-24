Return-Path: <linux-edac+bounces-5516-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF526C7F715
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 09:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6361934734D
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 08:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9692F2607;
	Mon, 24 Nov 2025 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHBmHwJp"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E742F25F6
	for <linux-edac@vger.kernel.org>; Mon, 24 Nov 2025 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763974678; cv=none; b=ISepJpi3encITtzRqk8uJMebaCPS0cS+pF6vxLXQ/s/BKwDus8uoSaYykcN9QRERlpjMsW0mY/iDd77w+Vu3JV80nMMYTp0RTKiKkayBMOVUCWX18lFLbNUnHoL1NiQEOI95IHrEuaxIeBLBLEEfYTlhtJjExCjm02wD7+zjLGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763974678; c=relaxed/simple;
	bh=J2bHmerP7OUNs8ZaWTEL1a8jMCTh21nVM4RfZB6/6Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQUKmFCqbolIsJL6+fm4aJvcqWzBJAwpblKlM6EWpFc2of1oG9vZ6nMa4muwDIa1Pk/5U3m30MfbTiDSfdq5sM0LPhGJNCIKGAab3dSBTC+jHOiGm0GJFUtlbsC8vjDa88fvSi3IuFHUqeEwUwjG1mX/srbXxgiOY0ODPFzDTSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHBmHwJp; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7aad4823079so3411537b3a.0
        for <linux-edac@vger.kernel.org>; Mon, 24 Nov 2025 00:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763974676; x=1764579476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=czb3fnbBSxKZv3Zr+URuWLRc9ArEdJmn0eOeXiDBNB8=;
        b=kHBmHwJpO1SZcyOsAMGphfX9jdyRP8iWBPW6O25aTuM90tIMWU2HLxrMvoS6P8td8P
         BSSfgcmeXjjjaXLTJSh32uwEl6lHm47sqhle/DZ6ZmfugKatizzXh/1/RbxuxCno3iAz
         WSe50Tig1Iw02X44ICTNOatdKXkDkw77ahd9L8n61e+wx9MuxXaNHWGdKDhckLRGHJA3
         a6f94j5b5cFbZyp6rcY6+jlV1r1md+DrKw0vrfOQiaG1eN9Ul1v7//H/ekXrmPCXq7Ir
         rvewrlLHGpg5gYzEAMwCGNxYtJJ7+aKo8Sle2DwQ17m99aZaKgeXa9FCumGknILayNzQ
         uZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763974676; x=1764579476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czb3fnbBSxKZv3Zr+URuWLRc9ArEdJmn0eOeXiDBNB8=;
        b=FdaAJqewcGl5P+gpLW8/lEablwCGMBVeKaqjAJ8Dizw/2pbGPaGLEwgYz7M//xQShQ
         pjzmrO8oHSRFWgWDcXEMqYX3I2NiRPlv7l3k4LboAsz4cyjEZQHHWw7S8btFD9uqx06z
         xWrkkzl6xTPkO3NCwv5T7xIIGxDrg4zPXSP5DhEAncG3kfqpkiuHJ51+FHeWQeq8hAu3
         yTKT8lySgW57iQRmF9zvlPYq9i57SVeLyDswyXcYBnJ/MTY/3si8xeqUrNLWAvkOYqxC
         mbXRGtQQ7PcHO6kpBTdQi8Us+XM4HqiCgo7L+yPB0/dxEQaP5miypVQikMHf3cl+8kZW
         Bf9Q==
X-Gm-Message-State: AOJu0Yw8QYrWFQt8/A6W/XzdZ2EdMJAabm+S9Z0UT9LvJ1r16JkFzdR7
	SrmaY8cYYJJUv4S9FCoZpdGEz5A1phHJxXZeR2mqB/p7tk+QpSrw3lJy
X-Gm-Gg: ASbGncv/40qlDwK7tGC0WjRlUzV0ee6trQ0B2zFL3TIB+x4lr0TS8FV4aJci4ElB233
	2zB+RhGe35h3y/IRCNcs7p8b/gCbiJKjyPb3koU/CUG3z3LgtltN7gtMb6FsHbKU5O/Kdp9PwZL
	Q3wVE7i5Zk3wO5uKmi55FYu2JWvdxg48nf32MWzKhov1lCDEzvFWpj0T3CXJxuExm6O7GeMt6A0
	+vHRlIDbEIjFcSy/Z8mMPxqymUdJyDfWBNXD+5bDImG28swY1zOon/gAOan+Aw+wY3oBLAC+nly
	PlbNR1eFETc4sB34RL5w+PStyGiegCOWJjgdA6CwvqT7xb0gh+05x3e+jp+1stxGhGTCZjiwl8G
	jukpf9OGB7rQKNQ0yYX28K01XEaqJDRrFzb/Qoi1jKxyfjbUzU30ee9SMMeTKdfJW1YiGY0edLo
	ZPSRQG2sV+ryUEgY0Fs3SK
X-Google-Smtp-Source: AGHT+IHFekblb7KicwQpReq80UtB03v/yPS7+MDXNbGBz9I+dfucMHhbuMp182FLflGYTFhQYw4QzA==
X-Received: by 2002:a05:6a20:914d:b0:35d:3b70:7629 with SMTP id adf61e73a8af0-36150e5fe3bmr11369237637.18.1763974675886;
        Mon, 24 Nov 2025 00:57:55 -0800 (PST)
Received: from google.com ([2401:fa00:95:201:ffba:e533:8aad:fcd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f174d2c0sm13799807b3a.66.2025.11.24.00.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 00:57:55 -0800 (PST)
Date: Mon, 24 Nov 2025 16:57:51 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de,
	Yazen.Ghannam@amd.com
Subject: Re: [PATCH v2] RAS/AMD/ATL: Remove bitwise_xor_bits
Message-ID: <aSQeD-RSZxeuPj_h@google.com>
References: <20251124084011.1575166-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124084011.1575166-1-nik.borisov@suse.com>

Hi Nikolay,

On Mon, Nov 24, 2025 at 10:40:11AM +0200, Nikolay Borisov wrote:
> Both LLVM/GCC support a __builtin_parity function which is functionally
> equivalent to the custom bitwise_xor_bits() one. Let's simplify the code by
> relying on the built-in. No functional changes.

IIRC in some cases, if the compiler decides not to inline
__builtin_parity(), it generates a libgcc function call like
__paritysi2(). Since the kernel currently lacks this symbol, this could
lead to a build failure at link time. Although the compiler inlines it
in most cases, I am not sure if using __builtin_parity() here is a good
idea.

Regards,
Kuan-Wei

> 
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
> 
> Changes since v1:
> 
> * Reworded the commit message
> 
>  drivers/ras/amd/atl/umc.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
> index 6e072b7667e9..7ff4a5a1c5da 100644
> --- a/drivers/ras/amd/atl/umc.c
> +++ b/drivers/ras/amd/atl/umc.c
> @@ -49,18 +49,6 @@ static u8 get_coh_st_inst_id_mi300(struct atl_err *err)
>  	return i;
>  }
> 
> -/* XOR the bits in @val. */
> -static u16 bitwise_xor_bits(u16 val)
> -{
> -	u16 tmp = 0;
> -	u8 i;
> -
> -	for (i = 0; i < 16; i++)
> -		tmp ^= (val >> i) & 0x1;
> -
> -	return tmp;
> -}
> -
>  struct xor_bits {
>  	bool	xor_enable;
>  	u16	col_xor;
> @@ -250,17 +238,17 @@ static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
>  		if (!addr_hash.bank[i].xor_enable)
>  			continue;
> 
> -		temp  = bitwise_xor_bits(col & addr_hash.bank[i].col_xor);
> -		temp ^= bitwise_xor_bits(row & addr_hash.bank[i].row_xor);
> +		temp  = (u16)__builtin_parity(col & addr_hash.bank[i].col_xor);
> +		temp ^= (u16)__builtin_parity(row & addr_hash.bank[i].row_xor);
>  		bank ^= temp << i;
>  	}
> 
>  	/* Calculate hash for PC bit. */
>  	if (addr_hash.pc.xor_enable) {
> -		temp  = bitwise_xor_bits(col  & addr_hash.pc.col_xor);
> -		temp ^= bitwise_xor_bits(row  & addr_hash.pc.row_xor);
> +		temp  = (u16)__builtin_parity(col & addr_hash.pc.col_xor);
> +		temp ^= (u16)__builtin_parity(row & addr_hash.pc.row_xor);
>  		/* Bits SID[1:0] act as Bank[5:4] for PC hash, so apply them here. */
> -		temp ^= bitwise_xor_bits((bank | sid << NUM_BANK_BITS) & addr_hash.bank_xor);
> +		temp ^= (u16)__builtin_parity((bank | sid << NUM_BANK_BITS) & addr_hash.bank_xor);
>  		pc   ^= temp;
>  	}
> 
> --
> 2.52.0
> 
> 

