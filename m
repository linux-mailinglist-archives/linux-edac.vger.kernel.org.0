Return-Path: <linux-edac+bounces-3712-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3261BA9BAF7
	for <lists+linux-edac@lfdr.de>; Fri, 25 Apr 2025 00:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65D721B6851D
	for <lists+linux-edac@lfdr.de>; Thu, 24 Apr 2025 22:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FA922127B;
	Thu, 24 Apr 2025 22:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LojGwPJg"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ABF20E6F7;
	Thu, 24 Apr 2025 22:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745535222; cv=none; b=Etkm2nOwLqA/Uth83ZjqvxsZubz7S5ctQydZDxvzz1f7Y8O+bBw2OZPLq9NkxWN7a7irX+/QCaj0AlMBG1GLLcCZF6XBUEQkh/RUBEg+CXSRqmdGeqaJPsE1yIkHTdSp0jwYde2dIdSdU+iO88i1lmLAiShTlCVNrVECZvmvs/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745535222; c=relaxed/simple;
	bh=x/vihavzm+XesAAD7Je7bq58o8bFuLRvzj/uyXWR/QQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5UWU7fY+CPmkuQkwzmIUcqTLdHMmm/mIWrAtYFG2ce8NSXBwkkfiWXUXAvEg13mBu9gpLPWCM5UGWpcopMWjpCpRU3VYZTSTtWJQoct+ck+4fRkq+BkfYtVCiaKahyY/Ju+00YzUmEbWFK28auoY1ryo9TunUmmPjcZvcZiLZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LojGwPJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9203AC4CEE3;
	Thu, 24 Apr 2025 22:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745535222;
	bh=x/vihavzm+XesAAD7Je7bq58o8bFuLRvzj/uyXWR/QQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LojGwPJgwb9Jesub/a47VZe0c49wG/QnB1WFqUZashB+5+owHfwnqltIlFQWYBkQ2
	 BPmE99jHBYq2FrM8L+u4tlO8qecgsyJigDx0HoYyFgL9H2ThDLx8Gp0kPEOUFp/3kD
	 PLLdKHTkvPdIT4GfWFTkZVBj5Drqa3U/T6+fq7HVHCbQAXTe3MMuGjaMn7pCTWfHzj
	 JNNl108RJsSQuTAZCWCd1lfDD6KIjGkkZi1llPYA+diDqxwgwWubu6EL+Yp7x13gBj
	 kjcfbgc+HgshAn9vgMKAHMKN03O0lus5o/QQdttL2I1GCKaI1cWi1fTlMMXAdxcdko
	 vpLwpDh+gcNjA==
Message-ID: <20e82d2c-b035-4bcd-82f7-807134101e28@kernel.org>
Date: Thu, 24 Apr 2025 17:53:38 -0500
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] EDAC/altera: fix cut and paste error
To: Matthew Gerlach <matthew.gerlach@altera.com>, bp@alien8.de,
 tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
 rric@kernel.org, tthayer@opensource.altera.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>, stable@kernel.org
References: <20250421161447.41886-1-matthew.gerlach@altera.com>
 <20250421161447.41886-2-matthew.gerlach@altera.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250421161447.41886-2-matthew.gerlach@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/21/25 11:14, Matthew Gerlach wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@altera.com>
> 
> Test correct structure member, ecc_cecnt_offset, before using it.
> 
> Fixes: 73bcc942f4271 ("EDAC, altera: Add Arria10 EDAC support")

Please just use a 12-digit HASH...

