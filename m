Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D356498FF1
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2019 11:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbfHVJqL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Aug 2019 05:46:11 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:54268 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732208AbfHVJqL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Aug 2019 05:46:11 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1i0jfT-0005ry-CC; Thu, 22 Aug 2019 11:46:07 +0200
Date:   Thu, 22 Aug 2019 11:46:07 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/8] AMD64 EDAC fixes
Message-ID: <20190822094607.GA14667@angband.pl>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
 <20190822005020.GA403@angband.pl>
 <20190822083548.GA11646@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190822083548.GA11646@zn.tnic>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 22, 2019 at 10:35:48AM +0200, Borislav Petkov wrote:
> On Thu, Aug 22, 2019 at 02:50:20AM +0200, Adam Borowski wrote:
> > While you're editing that code, could you please also cut the spam if ECC is
> > actually disabled?  For example, a 2990WX with non-ECC RAM gets 1024 lines;
> 
> Patch is in there. I'll give you extra points if you spot it.

Yeah, some of messages are no longer emitted for memory-less nodes (NUMA 1
and 3).  Your patch set also overhauls the messages.

But, the amount of redundant messages I'm complaining about has actually
increased:

dmesg|grep EDAC|cut -c 16-|sort|uniq -c
    256 EDAC MC: UMC0 chip selects:
    256 EDAC MC: UMC1 chip selects:
      1 EDAC MC: Ver: 3.0.0
    128 EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
    ^ three lines each
     64 EDAC amd64: F17h detected (node 0).
     64 EDAC amd64: F17h detected (node 1).
     64 EDAC amd64: F17h detected (node 2).
     64 EDAC amd64: F17h detected (node 3).
    512 EDAC amd64: MC: 0:     0MB 1:     0MB
    256 EDAC amd64: MC: 2:     0MB 3:     0MB
    256 EDAC amd64: MC: 2:  8192MB 3:     0MB
     64 EDAC amd64: Node 0: DRAM ECC disabled.
     64 EDAC amd64: Node 2: DRAM ECC disabled.
    256 EDAC amd64: using x4 syndromes.

(Full dmesg at http://ix.io/1T1o)

While on 5.3-rc5 without the patchset I get:

      1 EDAC MC: Ver: 3.0.0
    256 EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
    ^ three lines each
     64 EDAC amd64: Node 0: DRAM ECC disabled.
     64 EDAC amd64: Node 1: DRAM ECC disabled.
     64 EDAC amd64: Node 2: DRAM ECC disabled.
     64 EDAC amd64: Node 3: DRAM ECC disabled.

So I wonder if we could deduplicate those.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀ 
⣾⠁⢠⠒⠀⣿⡁ A dumb species has no way to open a tuna can.
⢿⡄⠘⠷⠚⠋⠀ A smart species invents a can opener.
⠈⠳⣄⠀⠀⠀⠀ A master species delegates.
