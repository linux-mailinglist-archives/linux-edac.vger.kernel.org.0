Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA44D60D2F1
	for <lists+linux-edac@lfdr.de>; Tue, 25 Oct 2022 20:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbiJYSF6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Oct 2022 14:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiJYSF5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 25 Oct 2022 14:05:57 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E3C18E3E;
        Tue, 25 Oct 2022 11:05:56 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e753329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e753:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D9C821EC0567;
        Tue, 25 Oct 2022 20:05:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666721154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aQMs5cu0gnuLwOAWwGf6Dtar4SZDXOYkZ1NChLc6yLs=;
        b=sCn3satnwa0cT4Jx+VnddoqBlqJ98BSfUdNT1Qbu13OlVtQAaw54p9Y3IS4NXPO8Hq5vLU
        EdXMC2uXn98hPsLXV+eVfk5HeTdJs8nacErw/klIxhWB06pyN5Xx1WtKsLmadI1FwU+i1C
        5hGrXfPMnTRIrwwTs6ws4i2s5xHBslg=
Date:   Tue, 25 Oct 2022 20:05:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/3] x86/MCE, EDAC/mce_amd: Add support for new
 MCA_SYND{1,2} registers
Message-ID: <Y1glfOlFE90SqjV/@zn.tnic>
References: <YtVlNrW58cFmksln@zn.tnic>
 <YukW/IltcCRwvSM4@yaz-fattaah>
 <Y1a4prRIYNw8GIkm@zn.tnic>
 <Y1a/lCVnlTMk8p75@agluck-desk3.sc.intel.com>
 <Y1b15vnE/Pd1U4r8@zn.tnic>
 <SJ1PR11MB608390D539CD4B405A195344FC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y1cCU9UqGG7nl8cy@zn.tnic>
 <SJ1PR11MB6083DBDAA90E1E03EC7A9EEAFC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB6083A794C876D6F44E530CAFFC2E9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y1gQQ8gh1CJf0Tuy@yaz-fattaah>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1gQQ8gh1CJf0Tuy@yaz-fattaah>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Oct 25, 2022 at 04:35:15PM +0000, Yazen Ghannam wrote:
> I think the "right way" to use tracepoints is to parse the data according to
> the format provided by the tracepoint itself. You can see an example of
> rasdaemon doing that here:
> https://github.com/mchehab/rasdaemon/blob/c2255178a49f62c53009a456bc37dd5e37332f09/ras-mce-handler.c#L386

Lemme add Rostedt.

So now we have libtraceevent and here's an example how to do it:

https://patchwork.kernel.org/project/linux-trace-devel/patch/20221021182345.092cdb50@gandalf.local.home/
https://www.trace-cmd.org/Documentation/libtracefs/libtracefs-kprobes.html

Reportedly, rasdaemon is still using the old libtraceevent method. So it
probably should be updated to use the new library version.

> A tracepoint user should not assume a fixed struct layout, so adding
> and rearranging fields shouldn't be a problem. I'm not sure about
> removing a field. It seems to me that this should be okay in the
> interface, and it's up to the application how it wants to handle a
> field that isn't found.

From looking at the examples, I think the new libtraceevent should be
able to handle all that just fine.

> Another option could be to define a new tracepoint.

Yeah, no. Let's get this one to work pls.

trace_mce_record2() looks like the old attempts to design a syscall
better. :)

>  Userspace already needs to be updated to recognize new fields, so I
> don't think it's much of a stretch to add a new tracepoint handler.

Syncing with other components is always a stretch. You're forgetting how
distros lag behind and don't always have the needed resources to update
their userspace.

Or they can't update because of enterprise raisins.

So no, it is not trivial, trust me. It's a bunch of politics and effort.

> This may be simpler than trying to fit vendor-specific info into an
> existing tracepoint and then decoding it later in userspace.

Until that new tracepoint becomes insufficient in the future and we need
to add trace_mce_record3(). No, you don't want that. :)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
