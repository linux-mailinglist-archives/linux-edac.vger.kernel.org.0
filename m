Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5456419ED47
	for <lists+linux-edac@lfdr.de>; Sun,  5 Apr 2020 20:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgDESGN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 5 Apr 2020 14:06:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:51800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbgDESGM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 5 Apr 2020 14:06:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4382EABE7;
        Sun,  5 Apr 2020 18:06:10 +0000 (UTC)
Date:   Sun, 5 Apr 2020 20:06:05 +0200
From:   Borislav Petkov <bp@suse.de>
To:     "Manali Shukla (manashuk)" <manashuk@cisco.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        Aristeu Rozanski Filho <arozansk@redhat.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Russ Anderson <rja@hpe.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [ PATCH stable v4.19] EDAC: Drop per-memory controller buses
Message-ID: <20200405180605.GC17324@zn.tnic>
References: <20200312052201.49456-1-manashuk@cisco.com>
 <20200317102249.GC1130294@kroah.com>
 <5D56C6A7-B076-47BB-9016-7BD54DFE71E7@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5D56C6A7-B076-47BB-9016-7BD54DFE71E7@cisco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Apr 05, 2020 at 06:01:21PM +0000, Manali Shukla (manashuk) wrote:
> With this patch , we are removing per-MC bus, this removes dependency on value of max number of controllers (EDAC_MAX_MCS) which is hardcoded to 2 * MAX_NUMNODES  in all stable versions of kernel. 
> 
> On two nodes system MAX_NUMNODES value is ‘1’ , so value of max number of memory controller becomes ‘2’, this patch fixes this issue when there are only 2 nodes on the system and number of memory controllers are more than ‘2'

You basically repeated what you had written already.

But what is this fixing? Some platform of yours or what? Why does it
need to go to stable?

Btw, please do not top-post and reply under the quoted text like all of
us do.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
