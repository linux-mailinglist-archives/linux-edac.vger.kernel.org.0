Return-Path: <linux-edac+bounces-5520-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E372BC805EC
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 13:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C9614EAABD
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 12:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008E52FFDDC;
	Mon, 24 Nov 2025 12:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjx3hFN+"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543AE2FF670
	for <linux-edac@vger.kernel.org>; Mon, 24 Nov 2025 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763985789; cv=none; b=bfo4JuN6txSmX1S+wuu1ugRA9MUqG6+pCxxq8yl61X6cVnZoexOu2hMXGYeSAMUkYjsk3hLZy8AlRFsnB4B7K8PjxCfXaS0XBS3oddXCAFETW8ZPQaW2pHYyRC9Z+3MtlomFVZBiB0v5h+aO3ZmJjmqzX0DaEYbkF2sGde1MB/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763985789; c=relaxed/simple;
	bh=k5GTtDI9s6nIRlDbv/w9jxXzQouOJh/3X0JGzvKsIc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppUFm33ZKd1EPaSxIB1uUthYvMmIHXjTADE9PX6sSGs6h1K2P8ool9SFyIihVUcyJOvqr3wBqZZ36cj8hHRTLbIeZMP+Ds2zia2+zIrnJPAmFe37cMxGm1skOXJv+8q1ya3af2Yorl0Ena7eSqF0slbAsoo8nVSplIf4GlF1Xxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjx3hFN+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo4883996b3a.2
        for <linux-edac@vger.kernel.org>; Mon, 24 Nov 2025 04:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763985787; x=1764590587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U7zD51i8UUvjK5YMM7TBk8yuIWlAihYctE+BATz3e18=;
        b=kjx3hFN+Ftl+QSlQzJL1PffZl2jl2/8OHuQif2mk6Xw2wKOZGoGNWldbddKIpPJvsG
         fYCbdzQ0yqhlCUqyPc3bK+Ow3pumBy9hSn5XdJHhExC4C3AtUQC9niBoE5UIDfn0h60f
         vHP2b9reQWBMORc20PugVwK8cAEF9pdxxKpMdo2kkVa1SAvXW/MUyXEIJi1qkSuzVhmz
         Oi3+rt02S8LB5xRtcXrpQG/h1wm3+yx+ttH5XvB1uOGLn+ZqF2f4M+pJXQjRq8jZ3Cyb
         Vpj+WzQR9MlCOTUMmZUTqqLKj/5TLLtaJ/SJLn4ubtNts74vb74HjCm6Uff8xMAx2Si0
         QXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763985787; x=1764590587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7zD51i8UUvjK5YMM7TBk8yuIWlAihYctE+BATz3e18=;
        b=WAX0O4s1597kPZl+3ZNgdbVN8bZgrJZO26TXQONP/hMXaFPowyDYTdxAfQO0ssK5fT
         N+szGHbfw0YNL4JBj84wVLS8BU93YzfWPPPLicdWARBNhoOo227xBzDnzfz9Aqyvfqrg
         DchGyD1nAbgJ+lifCRYPMyVthGpxm4jndOLThkWuVhsZNt1F03Y+HTGkK4faUpk7tnQF
         sICClO1IUsM4nqT+SjqmLBR3B8871hVUB1B3IiTuIzNPof8iLxNv1a1l9tehUr6MEHUY
         BO7/tu7ozrW5204oRmShsQpZ5WLk0dx6IHUm1KwfQrYBtSQIwTMWQvoDd3P4jmq9wqpU
         MPnw==
X-Forwarded-Encrypted: i=1; AJvYcCW4jDmp7vs2rZ2m0mXaMgE3I3QFqevIHCZHCn/rzpRUe61tFjO24/5Q6sMyeHiERx+4x1zRIsGqI7+z@vger.kernel.org
X-Gm-Message-State: AOJu0YzImn0XDjsd6NWCHHDpk3AbgUNZmlUlW40nHmJM/P4qVsJjzoi4
	PHq5riSA8UzDdED4SzzLigMUCe2F88BRrFo0y3gp0rRoZyT/xBITmaCr
X-Gm-Gg: ASbGnctf+SXcwgGgYBlKdn5m7vU7Q8C8+tg6JoyT/wC2lZDvM2HGAVafp63yv/Zdzyl
	4j4uC7h7vI6JUqtSks40ISbW+j0HMsJDuTXsxrmtJsg15QJZiANsI8cOTl8js/Eimr+z4+CPPHC
	4qW7ltU9NhF+SKsh1nJ0f/CZ+/E7XkhAL3MLV905dtI6HhMsy3q0Xhn/i2AdNR6Wk2tkP8L8Cj1
	SWMQLm+nAhtC/NYBHZOlK8U6gUe+uFCLfppXT8n6N5K/cyYOxssqYpndVGj4U2sbFi1aP94hf8y
	8Al7IsKAM+7seCRueWKVfPsElEl0/BaI6ytXN0ML7+Uq/FisHYP9jMJh/Dgboi9g7AIWY6fDwRP
	qe9n0giTv4FXQjMU7TzhnwvRXE8RwgCxY2CeqMHCzU2vN49r+q3vFKk+wbUASYmQg2DizSBPQV5
	jaas+GIJCncOIxD0trhnQObMzg
X-Google-Smtp-Source: AGHT+IG5DVoDYtCW8l3qVTT8DjEQ1FSk5zCsnH5zDEQwtm06FXqxK9B72e5zSRQCzRfeyyCgb7n/IQ==
X-Received: by 2002:a05:6a00:140d:b0:7b8:e83:1de4 with SMTP id d2e1a72fcca58-7c58c7a6bd1mr10695029b3a.9.1763985787373;
        Mon, 24 Nov 2025 04:03:07 -0800 (PST)
Received: from google.com ([2402:7500:499:ceaa:13f2:ed9d:8825:326b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0a67a4csm14660564b3a.48.2025.11.24.04.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 04:03:06 -0800 (PST)
Date: Mon, 24 Nov 2025 20:03:02 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Nikolay Borisov <nik.borisov@suse.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yazen.Ghannam@amd.com
Subject: Re: [PATCH v2] RAS/AMD/ATL: Remove bitwise_xor_bits
Message-ID: <aSRJdskInHGmbjIo@google.com>
References: <20251124084011.1575166-1-nik.borisov@suse.com>
 <aSQeD-RSZxeuPj_h@google.com>
 <20251124110526.GAaSQ79mo0yx1h1Xxm@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124110526.GAaSQ79mo0yx1h1Xxm@fat_crate.local>

Hi Borislav,

On Mon, Nov 24, 2025 at 12:05:26PM +0100, Borislav Petkov wrote:
> On Mon, Nov 24, 2025 at 04:57:51PM +0800, Kuan-Wei Chiu wrote:
> > > Both LLVM/GCC support a __builtin_parity function which is functionally
> > > equivalent to the custom bitwise_xor_bits() one. Let's simplify the code by
> > > relying on the built-in. No functional changes.
> > 
> > IIRC in some cases,
> 
> Which are those cases?
> 
> Do you have a trigger scenario?
> 
I did a quick search, and I believe it was this kernel test robot
report [1] that reminded me of this compiler behavior.

[1]: https://lore.kernel.org/oe-kbuild-all/202501312159.l6jNRaYy-lkp@intel.com/

Regards,
Kuan-Wei


