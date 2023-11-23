Return-Path: <linux-edac+bounces-84-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 885D57F60FF
	for <lists+linux-edac@lfdr.de>; Thu, 23 Nov 2023 15:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAC3B1C21152
	for <lists+linux-edac@lfdr.de>; Thu, 23 Nov 2023 14:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A402E837;
	Thu, 23 Nov 2023 14:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="KwvHoGfW"
X-Original-To: linux-edac@vger.kernel.org
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA2F1B2
	for <linux-edac@vger.kernel.org>; Thu, 23 Nov 2023 06:04:11 -0800 (PST)
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id 66o0r1M6hWcCI6AJPrytlg; Thu, 23 Nov 2023 14:04:11 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 6AJOrpMpkkUbt6AJOr0Jtm; Thu, 23 Nov 2023 14:04:10 +0000
X-Authority-Analysis: v=2.4 cv=WpU4jPTv c=1 sm=1 tr=0 ts=655f5bda
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=yGeM7+xMb5a5VK1DGQx1ew==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10
 a=TyODs4qkaV_lWZKKSI4A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h+9YDrrgXihyBNGSPCRa97Nm187+ooBonzAaom98yPE=; b=KwvHoGfWlgXmuikl+1Fzj4t30L
	VQ0qOH+dNUtobfYPsP9I9LGWc/bDTU6mVz36H4IYlpdLS4jhgqKFtStlFX49JmCtWLHeyE6zAs8+W
	cFUmNYOHROW7K0IZIoQo6bugGtCs5tdjmZxoG8wsVfTGVIyiKACu1sKeEjEo6QLtIttDWJ+nXnPHU
	NsnfBbAIhxYKmYKPALZkl58EmokbyikK5moYtWX2R5PaWzc0abYFAyBnWoXR3ay68elB/V/u6cQqq
	/Bnm2Pto3F6250fdat1QlMJvKuD7/RunRIVoSKGDVEhblMYVvy/efERwRTqgsCzcueXsoeVs5d7Dj
	MH6r2s9Q==;
Received: from 187.184.157.122.cable.dyn.cableonline.com.mx ([187.184.157.122]:63657 helo=[192.168.0.25])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1r6AJM-000Y6t-09;
	Thu, 23 Nov 2023 08:04:08 -0600
Message-ID: <f018b794-8af5-4c08-ae7f-0528a3e0f0e8@embeddedor.com>
Date: Thu, 23 Nov 2023 08:03:58 -0600
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC, thunderx: fix possible out-of-bounds string access.
To: Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@kernel.org>
Cc: Robert Richter <rric@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Sergey Temerkhanov <s.temerkhanov@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kees Cook <keescook@chromium.org>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Yeqi Fu <asuk4.q@gmail.com>,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231122222007.3199885-1-arnd@kernel.org>
 <20231123115812.GBZV8+VHPKYmKB/sva@fat_crate.local>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231123115812.GBZV8+VHPKYmKB/sva@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.157.122
X-Source-L: No
X-Exim-ID: 1r6AJM-000Y6t-09
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.122.cable.dyn.cableonline.com.mx ([192.168.0.25]) [187.184.157.122]:63657
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCmjPlS6WTcyg3KInqYgBEoiXlaSgHR25XqmDfCVx9DQphz7L160fUny9O6GglFR5otPmXnC5bGscMheL7v+1BtMybUzvFK3nrFUlTF9G9zofxrSF5yf
 gTX3BusdEQNMZucKRCezBPXFmZqkvwrNUu+dkafnV9vgdbOPY5iXbMBVj1wyeOqUyzraX9cPzRXMAUi/oWMijfsNffo+yXsp0rsm/koqLF+i6ApBipNmZgVj
X-Spam-Level: *



On 11/23/23 05:58, Borislav Petkov wrote:
> On Wed, Nov 22, 2023 at 11:19:53PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> Commit 1b56c90018f0 ("Makefile: Enable -Wstringop-overflow globally") exposes a
> 
> $ git describe 1b56c90018f0
> fatal: Not a valid object name 1b56c90018f0
> 
> I'm assuming that's in linux-next?

That's correct, yes.

--
Gustavo

