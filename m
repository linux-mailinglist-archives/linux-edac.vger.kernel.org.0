Return-Path: <linux-edac+bounces-130-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2DE7FBFF4
	for <lists+linux-edac@lfdr.de>; Tue, 28 Nov 2023 18:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF691C20D21
	for <lists+linux-edac@lfdr.de>; Tue, 28 Nov 2023 17:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359EA54BE0;
	Tue, 28 Nov 2023 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G/2XhO33"
X-Original-To: linux-edac@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD8210F0;
	Tue, 28 Nov 2023 09:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=/89j1WGuOEhmXDZoAr89HAOtI8MBBJgAUvR0nYQq0uo=; b=G/2XhO33W4alzsVgatxhkuF5Ik
	diPRGUuTND1Zgj2NbdUNI6RtWqDOu1MqUYsIwrEPaDT9cmShRs0AHkfoQn/EnNf/Qnwc8cSWTUT/6
	KoYcj7Etw1II8BHVeX+/IojXl2Oki7ZpsVYPuSpWjprnIJO5hyhUoUnF5s8p5HnaL0eoNJBvGDlmL
	0PqXELudFq+zLsHuYvaBmsvLyyq0mU4TWqycFECLZ1UGGU14jRV/BPfG/djPyXaHV0g9UuXm56kTZ
	cvQPCn+mSZN0vjlM0RHfvv5iwO6zcaXAXUkHPcMBTPlrEV3LWRhZlk3laLOqatEPHdjEmNOwdnD+X
	dbYyjY8Q==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r81VX-005sqQ-0v;
	Tue, 28 Nov 2023 17:04:23 +0000
Message-ID: <7c5c3634-7a89-48b3-96fa-4d9f3be3ba05@infradead.org>
Date: Tue, 28 Nov 2023 09:04:22 -0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Begin a RAS section
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Muralidhara M K <muralimk@amd.com>, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, Muralidhara M K <muralidhara.mk@amd.com>,
 linux-doc@vger.kernel.org
References: <20231102114225.2006878-1-muralimk@amd.com>
 <20231102114225.2006878-2-muralimk@amd.com>
 <20231128142049.GTZWX3QQTSaQk/+u53@fat_crate.local>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231128142049.GTZWX3QQTSaQk/+u53@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11/28/23 06:20, Borislav Petkov wrote:
> On Thu, Nov 02, 2023 at 11:42:22AM +0000, Muralidhara M K wrote:
>> From: Muralidhara M K <muralidhara.mk@amd.com>
>>
>> AMD systems with Scalable MCA, each machine check error of a SMCA bank
>> type has an associated bit position in the bank's control (CTL) register.
> 
> Ontop of this. It is long overdue:
> 
> ---
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Tue, 28 Nov 2023 14:37:56 +0100
> 
> Add some initial RAS documentation. The expectation is for this to
> collect all the user-visible features for interacting with the RAS
> features of the kernel.
> 

In general, does RAS include EDAC and MCE?

Thanks.

> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  Documentation/RAS/ras.rst | 26 ++++++++++++++++++++++++++
>  Documentation/index.rst   |  1 +
>  2 files changed, 27 insertions(+)
>  create mode 100644 Documentation/RAS/ras.rst
> 


-- 
~Randy

