Return-Path: <linux-edac+bounces-1374-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA40917879
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 08:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C22284E0E
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jun 2024 06:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6270638D;
	Wed, 26 Jun 2024 06:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="hj516aKd"
X-Original-To: linux-edac@vger.kernel.org
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1073A13C8F5;
	Wed, 26 Jun 2024 06:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719381803; cv=none; b=f6+uPlVWCsVfPTKR1UjoXrU7Xxo3M3OyPj51S6gakIwxm/u5dorPswF1ixiN0tQNRRxb6um5M2amuYgJPmB/uRoDss09/FFxPKrmb47+8569FgLcPSbiM71UBXzqPs3ZuGypPteKHW45y9/gjKASPqeWqrI01/ljIsUEQNKWP+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719381803; c=relaxed/simple;
	bh=m8YTY6GpEs3iSnFV8kd7Br7h+HDW2hkTnhnYCYUuL6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BC4LhEVg8tSUMA6OEXAIccegN/POdUIqpaGD3+1Yvem7063I3CxPgj1F6GUUMLgm89Y0QSoz8bNQqQZgRCHA9ZY9L0oClIQGnw0NQ0IvBnjZPjc4VSBjHIavxlAtCAuZgxsizC8Ai0MZVQ6qweM4GufO/tnXb0/5Xb4W4gjNdBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=hj516aKd; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1719381800; x=1750917800;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m8YTY6GpEs3iSnFV8kd7Br7h+HDW2hkTnhnYCYUuL6g=;
  b=hj516aKdtQp/v7XXeug7TE28dM5YyweZJHFzo6NZVeXD/GLFcdOaqqRJ
   mg4YEuV1+8MpcxXqkJl2YSLACzkUUPJ2SXR1+W8lsZMyf/IYm5w/iSVWW
   lNZ1g7pZhw2iGdCx2nouVaYXAIYRIJneL6AwF0DmaWOOLZo9FYA0EaBoc
   FVfoaiED+cGxduKAiqPgvlklTl+6q58m0MBr3MUktGBwDugCVXDYhXWFJ
   gRHaWuUe+Hw04nRlaj2SkINUb3yyyXr6gObqibwmNLJFukCcwucKyUwLR
   JrifZ/ahr748OcBdZ/JEJIZjTozs5XDGHjz16y5ZXg+AlPugu88CDm8n/
   Q==;
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="152361441"
X-IronPort-AV: E=Sophos;i="6.08,266,1712588400"; 
   d="scan'208";a="152361441"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 15:03:10 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id D62E5C13D0;
	Wed, 26 Jun 2024 15:03:07 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 4CC50BF4B7;
	Wed, 26 Jun 2024 15:03:06 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id CB1EF2007CA91;
	Wed, 26 Jun 2024 15:03:05 +0900 (JST)
Received: from [192.168.50.5] (unknown [10.167.226.114])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 087111A0002;
	Wed, 26 Jun 2024 14:03:03 +0800 (CST)
Message-ID: <bc58d99a-785f-4bb3-a9c9-9cf50ea7e06d@fujitsu.com>
Date: Wed, 26 Jun 2024 14:03:03 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cxl: avoid duplicating report from MCE & device
To: "Luck, Tony" <tony.luck@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 "Williams, Dan J" <dan.j.williams@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "dave@stgolabs.net" <dave@stgolabs.net>, "Weiny, Ira" <ira.weiny@intel.com>,
 "Schofield, Alison" <alison.schofield@intel.com>,
 "Jiang, Dave" <dave.jiang@intel.com>,
 "Verma, Vishal L" <vishal.l.verma@intel.com>, Borislav Petkov
 <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, "linux-edac@vger.kernel.org"
 <linux-edac@vger.kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
 <20240620180239.00004d41@Huawei.com>
 <6675bf92116ed_57ac294a@dwillia2-xfh.jf.intel.com.notmuch>
 <20240621194506.000024aa@Huawei.com>
 <SJ1PR11MB6083837A8588894E49FEBC7BFCC92@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <SJ1PR11MB6083837A8588894E49FEBC7BFCC92@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28482.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28482.005
X-TMASE-Result: 10--14.782900-10.000000
X-TMASE-MatchedRID: bdIiGNtle6uPvrMjLFD6eKn9fPsu8s0a2q80vLACqaeqvcIF1TcLYPAF
	43IXaj2gSY/hjDx7hppvUDqCNlsvKH+zsg6kp2C3Q0Xm0pWWLkroUwvpyt4rucg9ufahCGm1l2i
	SdQmYgPCf4Zlhm+r+lc5cp47XA8AiC9QTSuTOQRl+J3gtIe0gA8qspZV+lCSLdBaEtWosUzVYTF
	/5quaSLwftggnq5tKUMTii0wFdgxqOeQ6RXnGCFkX/j4QZJ10NajzNTFMlQCNtfzoljzPXO9F8e
	0i2JFlZ371UTvxX45vRKmOlruuzzop+5WdOMDCgv8fLAX0P50B2ZYwNBqM6IlLvEapiw2T1hXAr
	+h4GfTAIZNHliKo/PSm+XCxBE3RsKgAlgjPhYpaOtWfhyZ77Dn0tCKdnhB581B0Hk1Q1KyIOsEC
	O9s+GHnQdJ7XfU86eOwBXM346/+z07YdcTiNsP7Uv9Q5rrJhWezfWWH34ZgZxRwXGk1PHIsR47n
	50KUDY
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



在 2024/6/22 4:44, Luck, Tony 写道:
>> So who actually cares about recovering poisoned volatile memory?
>> I'd like to understand more on how significant a use case this is.
>> Whilst I can conjecture that its an extreme case of wanting to avoid
>> loosing the ability to create 1GiB or larger pages due to poison
>> is that a real problem for anyone today?  Note this is just the case
>> where you've reached an actual uncorrectable error and probably
>> / possibly killed something, not the more common soft offlining
>> of memory due to correctable errors being detected.
> 
> I guess you really need a reply from someone with a data center
> with thousands of machines, since that's where this question
> may be important.
> 
> My humble opinion is that, outside of the huge page issue, nobody
> should try to recover a poisoned page. Systems that can report
> and recover from poison have tens, hundreds, or more GBytes
> of memory. Dropping 4K pages will not have any measurable
> impact on a system (even if there are hundreds of pages dropped).
> 
> There's no reliable way to determine whether the poisoned page
> was due to some transient issue, or a permanent defect. Recovering
> a poisoned page runs the risk that the poison will re-occur. Perhaps
> next use of the page will be in some unrecoverable (kernel) context.
> 
> So recovery has some risk, but very little upside benefit.

Since the hardware provides the instruction(CPU)/command(CXL) to clear 
the poison, we could make the function work, at least as an optional 
feature.  Then users could decide to use it or not after evaluating the 
risk and benefit.

I think doing recovery is an improvement step, and may need a lot of 
discussion.  I'm not sure if we could reach a conclusion in this thread. 
  Just hope more comments on the original problem (duplicate report) to 
solve in this patch.


--
Thanks,
Ruan.

> 
> -Tony

