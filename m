Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597E14F1F37
	for <lists+linux-edac@lfdr.de>; Tue,  5 Apr 2022 00:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbiDDWrR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 4 Apr 2022 18:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344328AbiDDWqy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 4 Apr 2022 18:46:54 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C5B037BC0;
        Mon,  4 Apr 2022 14:56:58 -0700 (PDT)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 43C0A20DFD57;
        Mon,  4 Apr 2022 14:56:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 43C0A20DFD57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1649109418;
        bh=wNfTyQ0SC36j/wUbbN5U+OxggsGjrkK87ERhY/VNu3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kGygIAxVJ5W7hFUPl2Hl83I78rz5tvoUcXvk2nYbbbr7x5stmKlG4Wwbgt1+8BJlJ
         tf/xDB7QHJCZiQRHh7gmmkaQCuDUrvJulWQH9+aHBRr/4h4IhPWU5Rp9RZrvbwMxfk
         eJuji+vCAPk65uyd925d1qRrxF5ZZIbQ5WexhL6M=
Date:   Mon, 4 Apr 2022 16:56:40 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     Sasha Levin <sashal@kernel.org>, Lei Wang <lewan@microsoft.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Shiping Ji <shiping.linux@gmail.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/dmc520: Don't print an error for each unconfigured
 interrupt line
Message-ID: <20220404215640.GA626436@sequoia>
References: <20220111163800.22362-1-tyhicks@linux.microsoft.com>
 <YeRkGvestiloCAUV@zn.tnic>
 <20220118152816.GA89184@sequoia>
 <Yeb4sK+ZmSHjWPWL@zn.tnic>
 <20220118195401.GB89184@sequoia>
 <YecrXidqecoYI/xg@zn.tnic>
 <YefXQHXNlsxk8yUc@kroah.com>
 <Yefb7zO9p1iPF3Jm@zn.tnic>
 <YefnuCPwMq5V2lgl@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YefnuCPwMq5V2lgl@kroah.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2022-01-19 11:28:08, Greg Kroah-Hartman wrote:
> On Wed, Jan 19, 2022 at 10:37:51AM +0100, Borislav Petkov wrote:
> > On Wed, Jan 19, 2022 at 10:17:52AM +0100, Greg Kroah-Hartman wrote:
> > > For this specific change, I do NOT think it should be backported at all,
> > > mostly for the reason that people are still arguing over the whole
> > > platform_get_*_optional() mess that we currently have.  Let's not go and
> > > backport anything right now to stable trees until we have all of that
> > > sorted out, as it looks like it all might be changing again.  See:
> > > 	https://lore.kernel.org/r/20220110195449.12448-1-s.shtylyov@omp.ru
> > > for all of the gory details and the 300+ emails written on the topic so
> > > far.
> > 
> > It sounds to me I should not even take this patch upstream yet,
> > considering that's still ongoing...
> 
> Yes, I would not take that just yet at all.  Let's let the api argument
> settle down a bit first.

The API argument seems to have fizzled out in v2:

 https://lore.kernel.org/lkml/20220212201631.12648-1-s.shtylyov@omp.ru/

Can this fix be merged since there seem to be no API changes coming
soon? Boris, feel free to strip off the cc stable tag.

Tyler

> 
> thanks,
> 
> greg k-h
> 
