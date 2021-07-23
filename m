Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AFB3D30AB
	for <lists+linux-edac@lfdr.de>; Fri, 23 Jul 2021 02:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhGVXeE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Jul 2021 19:34:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:35219 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232550AbhGVXeD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 22 Jul 2021 19:34:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="297343473"
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="297343473"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 17:14:37 -0700
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="470872653"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 17:14:37 -0700
Date:   Thu, 22 Jul 2021 17:14:36 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jue Wang <juew@google.com>
Cc:     Borislav Petkov <bp@alien8.de>, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        x86 <x86@kernel.org>, "Song, Youquan" <youquan.song@intel.com>
Subject: Re: [PATCH 2/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210723001436.GA1460637@agluck-desk2.amr.corp.intel.com>
References: <CAPcxDJ7YsnYtyzSmgfBj-rmALkjigKx2ODB=SCYCzY8FJYg4iA@mail.gmail.com>
 <20210722151930.GA1453521@agluck-desk2.amr.corp.intel.com>
 <CAPcxDJ6bB7GEhTq9fkHuT4chRTUk_s-crci=nh+COCwAzMP8Yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcxDJ6bB7GEhTq9fkHuT4chRTUk_s-crci=nh+COCwAzMP8Yw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jul 22, 2021 at 04:30:44PM -0700, Jue Wang wrote:
> I think the challenge being the uncorrectable errors are essentially
> random. It's
> just a matter of time for >1 UC errors to show up in sequential kernel accesses.
> 
> It's easy to create such cases with artificial error injections.
> 
> I suspect we want to design this part of the kernel to be able to handle generic
> cases?

Remember that:
1) These errors are all in application memory
2) We reset the count every time we get into the task_work function that
   will return to user

So the multiple error scenario here is one where we hit errors
on different user pages on a single trip into the kernel.

Hitting the same page is easy. The kernel has places where it
can hit poison with page faults disabled, and it then enables
page faults and retries the same access, and hits poison again.

I'm not aware of, nor expecting to find, places where the kernel
tries to access user address A and hits poison, and then tries to
access user address B (without returrning to user between access
A and access B).

-Tony
