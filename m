Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B140C988B6
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2019 02:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfHVAu0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Aug 2019 20:50:26 -0400
Received: from tartarus.angband.pl ([54.37.238.230]:47858 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfHVAu0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 21 Aug 2019 20:50:26 -0400
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.92)
        (envelope-from <kilobyte@angband.pl>)
        id 1i0bIy-0000Fv-Q6; Thu, 22 Aug 2019 02:50:20 +0200
Date:   Thu, 22 Aug 2019 02:50:20 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: Re: [PATCH v3 0/8] AMD64 EDAC fixes
Message-ID: <20190822005020.GA403@angband.pl>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Aug 21, 2019 at 11:59:53PM +0000, Ghannam, Yazen wrote:
> I've also added RFC patches to avoid the "ECC disabled" message for
> nodes without memory. I haven't fully tested these, but I wanted to get
> your thoughts. Here's an earlier discussion:
> https://lkml.kernel.org/r/20180321191335.7832-1-Yazen.Ghannam@amd.com

While you're editing that code, could you please also cut the spam if ECC is
actually disabled?  For example, a 2990WX with non-ECC RAM gets 1024 lines;
64 copies of:

[    8.186164] EDAC amd64: Node 0: DRAM ECC disabled.
[    8.188364] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
                Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effects.)
[    8.194762] EDAC amd64: Node 1: DRAM ECC disabled.
[    8.196307] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
                Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effects.)
[    8.199840] EDAC amd64: Node 2: DRAM ECC disabled.
[    8.200963] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
                Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effects.)
[    8.204326] EDAC amd64: Node 3: DRAM ECC disabled.
[    8.205436] EDAC amd64: ECC disabled in the BIOS or no ECC capability, module will not load.
                Either enable ECC checking or force module loading by setting 'ecc_enable_override'.
                (Note that use of the override may cause unknown side effects.)


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁
⢿⡄⠘⠷⠚⠋  The root of a real enemy is an imaginary friend.
⠈⠳⣄⠀⠀⠀⠀
