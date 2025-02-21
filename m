Return-Path: <linux-edac+bounces-3177-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B4CA3E9C0
	for <lists+linux-edac@lfdr.de>; Fri, 21 Feb 2025 02:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82BFE16B572
	for <lists+linux-edac@lfdr.de>; Fri, 21 Feb 2025 01:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F50E288B1;
	Fri, 21 Feb 2025 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2Knk3HP"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4343A4A3C;
	Fri, 21 Feb 2025 01:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100562; cv=none; b=qWuoWbrPfTPBgK4kr9sS4LhaeupNJ2uIy7U8vekPfc17iK8+j9dR+RuxpWSZFy/ToH5xotHXGdOcC0c9JUJ4XA2AneQ+J0L1HnpylYM5ICeIlV4Xb9PMypsDZFIVki+2hmp83xKvYtORGW9z2ljOrJX76C58u7tAeGIyPDBIZ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100562; c=relaxed/simple;
	bh=gyIM0fE6vdkH0jx2sgUur4igv5Hb2Gn6rMXBdbz6yDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UG/jZ0tlV4n/qxRhbEtqI38eeAeqbw8edTLfJibyMwOEM3KgXYEplrW6E9YZLoQw0WqErAp0FCBydFb43mG9SPMP7jGW5gs4mu43xDZO7SuTeE5SoZaZz39We2OLx//kFv9Ys0q+QCwaNqmNITI5DEuLQMdwTk/X2q94sJoKlkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2Knk3HP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740100560; x=1771636560;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gyIM0fE6vdkH0jx2sgUur4igv5Hb2Gn6rMXBdbz6yDM=;
  b=X2Knk3HPKV3cSSt82+MDfvLH+SUY5Lq3NIs+SMdgdc+l/nsZMkWwZc8H
   t8a/OqWHYYehoaH82ZTsoG7qNq2ZHXQJ2eBCRvi3DleVTJgUV6edSzd/V
   QnS5IIs4uP93rdD6nnUlpBqTQpT8w+I6qdyhJv5KkpcL556xD9lY3C+cz
   3Z0lhdJwLIyOa1+DwwLLVxOKjFT7/D54Ivg/+/KJNEENGmoditPl7BEmH
   pTqRb66JGmYWFY7IDLEq4/Y6XS+tkpoVr3mbQyy1hDC2ZiShiYuEPY8IQ
   cXMbOByvfe3QxGWb6BdTw4CZhxZctQeHMrqQyfaCyKf4fOn+9xBLnOnry
   Q==;
X-CSE-ConnectionGUID: QqobFgPBRFGpZErFM0On8w==
X-CSE-MsgGUID: bnvSL6kwTC273jdy8EY2TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40095235"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="40095235"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 17:16:00 -0800
X-CSE-ConnectionGUID: 7mhXjt00RTSp6yR5TGcWkw==
X-CSE-MsgGUID: 8CSl+ZhhSwe9F2eGRUfMQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="138429912"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 17:15:59 -0800
Date: Thu, 20 Feb 2025 17:15:58 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Kevin Chang <kevin1.chang@intel.com>,
	Thomas Chen <Thomas.Chen@intel.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] EDAC/{skx_common,i10nm}: Fix some missing error
 reports on Emerald Rapids
Message-ID: <Z7fTzrl4cYuu5W9Y@agluck-desk3>
References: <20250214002728.6287-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214002728.6287-1-qiuxu.zhuo@intel.com>

On Fri, Feb 14, 2025 at 08:27:28AM +0800, Qiuxu Zhuo wrote:
> When doing error injection to some memory DIMMs on certain Intel Emerald
> Rapids servers, the i10nm_edac missed error reports for some memory DIMMs.
> 
> Certain BIOS configurations may hide some memory controllers, and the
> i10nm_edac doesn't enumerate these hidden memory controllers. However, the
> ADXL decodes memory errors using memory controller physical indices even
> if there are hidden memory controllers. Therefore, the memory controller
> physical indices reported by the ADXL may mismatch the logical indices
> enumerated by the i10nm_edac, resulting in missed error reports for some
> memory DIMMs.
> 
> Fix this issue by creating a mapping table from memory controller physical
> indices (used by the ADXL) to logical indices (used by the i10nm_edac) and
> using it to convert the physical indices to the logical indices during the
> error handling process.
> 
> Fixes: c545f5e41225 ("EDAC/i10nm: Skip the absent memory controllers")
> Reported-by: Kevin Chang <kevin1.chang@intel.com>
> Tested-by: Kevin Chang <kevin1.chang@intel.com>
> Reported-by: Thomas Chen <Thomas.Chen@intel.com>
> Tested-by: Thomas Chen <Thomas.Chen@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Applied to RAS tree edac-drivers branch

Thanks

-Tony

