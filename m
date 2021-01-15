Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D2F2F8958
	for <lists+linux-edac@lfdr.de>; Sat, 16 Jan 2021 00:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbhAOXY3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 15 Jan 2021 18:24:29 -0500
Received: from mga18.intel.com ([134.134.136.126]:42084 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbhAOXY3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 15 Jan 2021 18:24:29 -0500
IronPort-SDR: WqdxCW4u0AS92VBz43GxkFoSaYd7GwkpYfXPLatreLUjgLA+uIBYXmSGfvd43Cb8OjlvMxvCSj
 78VzKiTc5F2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="166290202"
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="166290202"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 15:23:48 -0800
IronPort-SDR: 7gXHaJJl7pLab/RhcPWWxWPifCml+C+HQtTefTRRM4NPihwK/TL1eymOTTxNfIb7YS9PgPkzIr
 ClHk1mvq2RFw==
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="382833317"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 15:23:48 -0800
Date:   Fri, 15 Jan 2021 15:23:46 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210115232346.GA7967@agluck-desk2.amr.corp.intel.com>
References: <20210111214452.1826-1-tony.luck@intel.com>
 <20210115003817.23657-1-tony.luck@intel.com>
 <20210115152754.GC9138@zn.tnic>
 <20210115193435.GA4663@agluck-desk2.amr.corp.intel.com>
 <20210115205103.GA5920@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210115205103.GA5920@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 15, 2021 at 12:51:03PM -0800, Luck, Tony wrote:
>  static void kill_me_now(struct callback_head *ch)
>  {
> +	p->mce_count = 0;
>  	force_sig(SIGBUS);
>  }

Brown paper bag time ... I just pasted that line from kill_me_maybe()
and I thought I did a re-compile ... but obviously not since it gives

error: ‘p’ undeclared (first use in this function)

Option a) (just like kill_me_maybe)

struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);

Option b) (simpler ... not sure why PeterZ did the container_of thing

	current->mce_count = 0;

-Tony
