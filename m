Return-Path: <linux-edac+bounces-4567-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F9DB234FF
	for <lists+linux-edac@lfdr.de>; Tue, 12 Aug 2025 20:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3BB1A24A3A
	for <lists+linux-edac@lfdr.de>; Tue, 12 Aug 2025 18:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775DC2FF164;
	Tue, 12 Aug 2025 18:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yQgyeJ+v"
X-Original-To: linux-edac@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B002FD1AD;
	Tue, 12 Aug 2025 18:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024124; cv=none; b=ti+TWW7VwJrOTLp+f1HYGLZYHlyA1A71EvVHZ13QXkeC3OHmDptC4fDKvwTaHVtWofkAtyXef3BE1EnGT+1wt8NcVrkn3kQOW5YaaqcYwe9iozPoXEB6e1WXxbELZs9+PxE9XYXsL4t510/3wLtwHrBPdfjZMQvBHOrgmGCTmME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024124; c=relaxed/simple;
	bh=YjV5DM7i5vfTBStJBu8Kywd0Ft5kKFglI7QFrz3GbUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/yQ23+WbFrjubx1dS47ij471+xSfbFAqqayc9AlAaBSzmLIGR49PEsZ/I/rPaAFFkLHdM7O11aJIP327w5NPx/gV53l60RBtHoS2lzHx5WVMxBS/KcFBNgpLs8wcGCRo1/CEdHPt4wpy5Ce93cjXqsiIQtFOBA/CDD9+L2xxhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yQgyeJ+v; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=FHxkqkCIby6/Iwqsc8oIyaMEmmoKiEI2VaqX4PkNjA4=; b=yQgyeJ+v3xmajheA8wQcWn/qgm
	Q9nr4AETXhsY2N8iAHfrQAhE9WY1x7I7309HIPgTU7MI3KGFJLhAaDMPmpmuYFr/DJRrp2+0Urm8S
	nOKPzaseTLmUVmClk89LwlEw5/aG0cRHMDGL4Q6fTD5qP0lIxvmEhhenPJaohLLqhEHbOyLrMCq9C
	NGrSG3+kDojmyqNIu9Cq6dKDv3G78Hb5Z4e9cHm44ZyhVdixfzvr2fazbXPGlVXV97lvnRFtQ+pXb
	PU+0U3sxkpoGqJcGwX3heIN8d2vUmw+NhdvIkIEy3WAIByPPAzN3Ui0XzKYxTdgtSAZFS21FxlYAX
	Vz/y+diw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ultwd-0000000BjH6-38xA;
	Tue, 12 Aug 2025 18:41:59 +0000
Message-ID: <e8731f6f-9057-46f0-8df0-7ece500c0928@infradead.org>
Date: Tue, 12 Aug 2025 11:41:58 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL for v6.17-rc2] add a generic yaml parser integrated
 with Netlink specs generation
To: Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
Cc: EDAC Mailing List <linux-edac@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Akira Yokosawa <akiyks@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Ignacio Encinas Rubio <ignacio@iencinas.com>, Marco Elver
 <elver@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jan Stancek <jstancek@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Ruben Wauters <rubenru09@aol.com>, joel@joelfernandes.org,
 linux-kernel-mentees@lists.linux.dev, lkmm@lists.linux.dev,
 netdev@vger.kernel.org, peterz@infradead.org, stern@rowland.harvard.edu,
 Breno Leitao <leitao@debian.org>, Simon Horman <horms@kernel.org>
References: <20250812113329.356c93c2@foz.lan> <87h5ycfl3s.fsf@trenco.lwn.net>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87h5ycfl3s.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/25 11:31 AM, Jonathan Corbet wrote:
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
>> Hi Jon/Jakub,
>>
>> In case you both prefer to merge from a stable tag, please pull from:
>>
>> 	git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-docs.git docs/v6.17-1
>>
>> For:
>>
>> - An YAML parser Sphinx plugin, integrated with Netlink YAML doc
>>   parser.
> 
> OK, I have done that.  I will note that it adds a warning:
> 
>> Documentation/networking/netlink_spec/index.rst: WARNING: document isn't included in any toctree
> 
> ...it might be nice to get that straightened out.

I see it, at least in linux-next. However, its format is
"different," so that may have confused whatever printed
that message:

from Documentation/networking/index.rst:

   filter
   generic-hdlc
   generic_netlink
   netlink_spec/index
   gen_stats
   gtp
   ila


-- 
~Randy


