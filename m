Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0069760B4B1
	for <lists+linux-edac@lfdr.de>; Mon, 24 Oct 2022 20:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiJXSAa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Oct 2022 14:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiJXSAL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 24 Oct 2022 14:00:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2429ADBE69;
        Mon, 24 Oct 2022 09:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666629647; x=1698165647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1fK2T1O5gksLCoeEx0nqKMvdwGeInG+0UhfTFUkDIo4=;
  b=m1K926g8fZlEHlePvBySSZyP3ZAUwSh91elvBCA1imS8uzIV6kquQTiy
   pfIzG5m1wodNi0yBsxrpVxMavMBq1440zRmQ+B1pzuzvB6uDxriFISz/o
   arHKdcCeo7vTf5d17X/s2i7u3v+0G3iRtR2YckdRiFBwgNh3nQevLZGyP
   qHxwHxDAH84NT9MaezfHv0+k4M4ym9hvZ90IBJ35D+WCvjIcRUCZAIrMU
   wi7NYRPKTBJ4ciTgg1mXVOS47o0vyxXoRIP1dx6lM+o0TqvgoSTJ5xiwA
   R1dCZ7QC8sQHlRd4EDowLK2AzTa4JQBFIR0N1qIhThER4FzsmvXaydLqr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287864703"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="287864703"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 09:38:46 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="700223900"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="700223900"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 09:38:46 -0700
Date:   Mon, 24 Oct 2022 09:38:44 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH 1/3] x86/MCE, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Message-ID: <Y1a/lCVnlTMk8p75@agluck-desk3.sc.intel.com>
References: <20220418174440.334336-1-yazen.ghannam@amd.com>
 <20220418174440.334336-2-yazen.ghannam@amd.com>
 <Yr2CpuL+JHWblJMD@zn.tnic>
 <YsxefXQDCiJ1zxLG@yaz-fattaah>
 <YtUgb2Y/H/Wq9yIn@zn.tnic>
 <YtVlNrW58cFmksln@zn.tnic>
 <YukW/IltcCRwvSM4@yaz-fattaah>
 <Y1a4prRIYNw8GIkm@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1a4prRIYNw8GIkm@zn.tnic>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 24, 2022 at 06:09:10PM +0200, Borislav Petkov wrote:
> On Tue, Aug 02, 2022 at 12:22:20PM +0000, Yazen Ghannam wrote:
> > I ask because struct mce is UAPI. But I think this is just for /dev/mcelog,
> > and this has been deprecated for a while. So on a related note, should
> > /dev/mcelog be removed and struct mce moved out of UAPI? Then changes to
> > struct mce won't affect user space, and we can just consider the mce trace
> > event when reporting to user space.
> 
> Question is, do you want those error records to be fed into mcelog on
> AMD too?
> 
> And I remember you guys supporting it at some point.
> 
> The answer to that question will tell you how exactly to build your
> structure of data you shuffle to luserspace.

There are still a fair number of users of mcelog, so I think it needs
to remain in its half-undead state a while longer.

Changes to "struct mce" have always been supported. Several have
been made over the years. The rules are quite simple:

1) Do not remove any existing fields
2) Legacy fields that are no longer used should have value 0.
3) Kernel internal values (currently just "kflags") should be
   zeroed in the structures passed out to user space.
3) New fields must be added at the end.

-Tony
