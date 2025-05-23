Return-Path: <linux-edac+bounces-3994-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD10AC29AA
	for <lists+linux-edac@lfdr.de>; Fri, 23 May 2025 20:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89F91899871
	for <lists+linux-edac@lfdr.de>; Fri, 23 May 2025 18:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EFA299AAD;
	Fri, 23 May 2025 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="A4XHMC7b"
X-Original-To: linux-edac@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA1C296FCA;
	Fri, 23 May 2025 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748024812; cv=none; b=KPHFCe4UyZeKP8DwVz9Jrvrv+0Dyxx2vx4gc3RKqJjaezbwSSx+H//RVl0MO5uaxFvnsIQfbeNsN9Ljeo3ZbOZ465EiDfm2rwz1TO/ftb192uLQiYVXPESisG2gXE2th83nTZbDojZWfNJccSrqHNnwYr7ygjwIC+3WbWvhdZk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748024812; c=relaxed/simple;
	bh=uPjxz/TLwcbVLcL3f2SNThjlRYnJ3po54HMlkTbgEwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQOXYAi126JRJaC6DXFfJ904Jo173YZ2Wn5YXhPmoE3U7kdDqEEC8f01YhMN7YUGvek/4ZHgxPXKADmSb3YM/uYqXR103En4CB5/VC8HINeDqlA10Wht/aJsNR2w2DekqjnZkk2UtF1o9OP9JKq8cAm8TTEX1AsMB86AHuw6FR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=A4XHMC7b; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.93.0.87] (unknown [40.118.131.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id 651C8206833E;
	Fri, 23 May 2025 11:26:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 651C8206833E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1748024810;
	bh=uK5hiG74PDBhRm4CulTTBysmn1guVT7r+QJpSJxEVrI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A4XHMC7bnaaZeKOKMlz54lKRlCuccdqcaoLk3d/4MBwaVkCxSvr7X5lMuTb5eXFni
	 NTFQs81mwGECEa8gs7JvBCfXt5i0zWB7TETbfSm/Otdz8w+NRKnF99419rF29ee1OX
	 0M4P7kPY4qQF4h4/qwCJhhBg/JYsOknOzNjf4FIQ=
Message-ID: <a40e3c38-4ccc-45c8-921d-2d8ed8fe449b@linux.microsoft.com>
Date: Fri, 23 May 2025 11:26:48 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drivers/edac: Add L1 and L2 error detection for A72
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tyler Hicks <code@tyhicks.com>, Marc Zyngier <maz@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, devicetree@vger.kernel.org
References: <1747353973-4749-1-git-send-email-vijayb@linux.microsoft.com>
 <1747353973-4749-2-git-send-email-vijayb@linux.microsoft.com>
 <20250520103500.00003905@huawei.com>
Content-Language: en-US
From: Vijay Balakrishna <vijayb@linux.microsoft.com>
In-Reply-To: <20250520103500.00003905@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/25 02:35, Jonathan Cameron wrote:
> On Thu, 15 May 2025 17:06:11 -0700
> Vijay Balakrishna<vijayb@linux.microsoft.com>  wrote:
> 
>> From: Sascha Hauer<s.hauer@pengutronix.de>
>>
>> The Cortex A72 cores have error detection capabilities for
>> the L1/L2 Caches, this patch adds a driver for them. The selected errors
>> to detect/report are by reading CPU/L2 memory error syndrome registers.
>>
>> Unfortunately there is no robust way to inject errors into the caches,
>> so this driver doesn't contain any code to actually test it. It has
>> been tested though with code taken from an older version [1] of this
>> driver.  For reasons stated in thread [1], the error injection code is
>> not suitable for mainline, so it is removed from the driver.
>>
>> [1]https://lore.kernel.org/all/1521073067-24348-1-git-send-email-york.sun@nxp.com/#t
>>
>> Signed-off-by: Sascha Hauer<s.hauer@pengutronix.de>
>> Co-developed-by: Vijay Balakrishna<vijayb@linux.microsoft.com>
>> Signed-off-by: Vijay Balakrishna<vijayb@linux.microsoft.com>
> Hi.
> 
> Some issues with release of device_nodes in the of parsing code.

Thank you, Jonathan for review. I'm addressing your comments and posting 
next series soon.

Vijay

