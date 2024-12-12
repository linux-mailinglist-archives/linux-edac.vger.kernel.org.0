Return-Path: <linux-edac+bounces-2703-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E859EE92B
	for <lists+linux-edac@lfdr.de>; Thu, 12 Dec 2024 15:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E91528959D
	for <lists+linux-edac@lfdr.de>; Thu, 12 Dec 2024 14:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0765E2165E7;
	Thu, 12 Dec 2024 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L0qR51bh"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF7084D02;
	Thu, 12 Dec 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014447; cv=none; b=b46VngpzeBa2j1Lo2lU4QJF4nxEHsnb0FEAyO9FV+xzXWxWkNGrzYLE0SLiHa+ZpczU/ItsQ/SPSLIZbAWl7D+jKU5kWFZ0RiNP1fRvCd2PY8POpbdCSZUXMBzCNR2700QgiFv4nYQzf6mSN+MXl+AmAYyqMPWR1/cqdVg5fdlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014447; c=relaxed/simple;
	bh=uT99vokurkNWoJip5ijW3HPDM4WNthH/1sPQ7awVt3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHIrS3jwnw6qipzX8H6es0+pjhJmmzVLtcni5ogDXlY/8WFEqbDp5pNa8ciQWNDvW76c52/S6g8wniTx7UrPl8liVsESKw6BA4kTdAesxfmULNiuLCePy9oegoKiLUduskz2RGZ94K+CZRngwbsDOKsAvKBE5/TeaZJBB9vY480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L0qR51bh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB8BC4CECE;
	Thu, 12 Dec 2024 14:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734014447;
	bh=uT99vokurkNWoJip5ijW3HPDM4WNthH/1sPQ7awVt3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L0qR51bho2lJ0vlfK7+wt+VD39N8ZKdIF7/2FcwWOyG2mazcj7hupDYwRDK5eQ9EQ
	 es0MFCi3iaTPnCmUtve/9NDMEylgVEmosnl3o8IefAPvAKPG0QgxWFbcQXSRpe9vah
	 MASmlvp3g+fRwrwDkSbnIolPEF8rGSoTlLOZyk9U=
Date: Thu, 12 Dec 2024 09:40:45 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Karan Sanghavi <karansanghvi98@gmail.com>, bp@alien8.de, 
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3] RAS/AMD/ATL: Fix unintended sign extension issue from
 coverity
Message-ID: <6qdhlwbfurmhur3bbhjn77b2vohfnuf5cnyfhmph7kvqfvctxd@glaobjy65vle>
References: <20241127-coverity1593397signextension-v3-1-60dd0c4287ff@gmail.com>
 <20241211160113.GB1923270@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211160113.GB1923270@yaz-khff2.amd.com>

On Wed, Dec 11, 2024 at 11:01:13AM -0500, Yazen Ghannam wrote:
> One minor nit: the Reviewed-by tag should go after the Signed-off-by.
> This is noted in the "tip tree handbook":
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#ordering-of-commit-tags

It depends on who is applying the trailer, because b4 uses the
"chain-of-custody" approach to trailer ordering:

https://lore.kernel.org/tools/20221031165842.vxr4kp6h7qnkc53l@meerkat.local/

The gist of that approach is that the "Signed-off-by" trailer indicates the
custody boundary. Anything above that line is the responsibility of the person
mentioned in the S-o-B. Anything below that line is the responsibility of the
person who is the next S-o-B.

> 
> The EDAC and RAS subsystems generally follow the "TIP" group guidelines,
> in my understanding.
> 
> I see you're using "b4", so you may want to adjust the "trailer-order"
> config option. I've been trying out b4 myself, so this is fresh in my
> mind.
> https://b4.docs.kernel.org/en/latest/config.html

The trailer-order config option will only apply within the custody boundary.

Best wishes,
-K

