Return-Path: <linux-edac+bounces-3082-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23A2A35163
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 23:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DB03ACF0E
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 22:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4259C26E14D;
	Thu, 13 Feb 2025 22:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFwCM/rp"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33D32661B9;
	Thu, 13 Feb 2025 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486431; cv=none; b=i1l00mE24vkRb6PJrrU/2eMWe2RlUY0eT4qzMqwso3knKYHvgukqo0wKK6s+d/JHuwdoziXL86w84Vi3AAjMCyecA9sSkFdB98sDCw3Cf1YPxQyVgHbeivXiKFIasJoMVfGVMtn4Mt2VZQzK8bhoagOzKxBlgUydk9xM5C8Jzqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486431; c=relaxed/simple;
	bh=3wvWF5bWcW3wB/VHLlUfEjtZ2gvJyAfjBMJDu7tb44o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqRbxU3I2E4t0StgS3E7HQYMcRN3aKLQMdrZQ5ZqD0vHqZkLbiWUMjiPE+AnDmWJY1qiJVrGgc83vOEruzmNb9FwlWHuDVL2fuo2u8eWom8UrPQh5XwIpn3DuceRQT7yG7zG7ccZuSZKq8fZbDLv344cocBhgTlYeo7/wLW5yXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFwCM/rp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739486430; x=1771022430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3wvWF5bWcW3wB/VHLlUfEjtZ2gvJyAfjBMJDu7tb44o=;
  b=iFwCM/rpWH1x+ue+srkxc69ZO1l7L/ShjWXYRsnMgaCR/DPIsQcE4gzl
   6nNBBWuKe8uGlmUqKJAJmEFdG5QvtmxzBwNZonZ8jJMzwOq4GFp9JoFZw
   Lr/Otdy3JkVPcSPE0WQYpBMY0qB33Cf6b6xCcBrVR4hOSSPoRHkAFg3Hl
   kDb/yvYLEaE+33ksJ0psjMv0TGVvUITWKw5XqEmA6OWnIwNxstwvat5do
   yVmB84/FlHkllJw1oLJ3XBArg6UPEZklfaCw/MsvBLl+o8F2sFnrvrOkv
   R6Cb446IVnhpcxgWIA2oZnl1N8sW8kcswzpcogl2FmD7rGEdYrV8FLRv+
   w==;
X-CSE-ConnectionGUID: pgOW+XztQ7S+q/Yd/UGfMQ==
X-CSE-MsgGUID: JDqYxjxZTuyG95J3vSrWFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="57755987"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="57755987"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:40:29 -0800
X-CSE-ConnectionGUID: DVedKDbJROOUzwyO6jEiBw==
X-CSE-MsgGUID: 6xFdQKMpRde2519ShzZkVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114161630"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:40:29 -0800
Date: Thu, 13 Feb 2025 14:40:27 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 00/16] AMD MCA interrupts rework
Message-ID: <Z6502yAjieRlPuoc@agluck-desk3>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>

On Thu, Feb 13, 2025 at 04:45:49PM +0000, Yazen Ghannam wrote:
> Hi all,
> 
> This set unifies the AMD MCA interrupt handlers with common MCA code.
> The goal is to avoid duplicating functionality like reading and clearing
> MCA banks.
> 
> Based on feedback, this revision also include changes to the MCA init
> flow.

Apart from the nits I posed againt parts 5 & 15. LGTM.

Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>

-Tony


