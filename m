Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABE7D1315EF
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2020 17:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgAFQUU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 6 Jan 2020 11:20:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41922 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726448AbgAFQUU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 6 Jan 2020 11:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578327619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A//7RTxR7XBGOrJW7JV8mMzhCoA5DQVAHjN62Jqintw=;
        b=UyGontxm3EEeBdu67Vc+z8CQ2AW/p5VqN6l6Clpk8XQbL1TxMPFimgpdXjLnN6qpZbujse
        l2nhh586X0vNcTG/v5nqowV4486gBp2YSnOLlaPUW3J7mAYleYn+RavI+0CyeLUpT5GnRR
        vb9sokrhQ9vqkjU5gK60sbxKzl8NxgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-lED_zQAyNtW_2PjGbva_gw-1; Mon, 06 Jan 2020 11:20:15 -0500
X-MC-Unique: lED_zQAyNtW_2PjGbva_gw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7CCC9216DB;
        Mon,  6 Jan 2020 16:20:14 +0000 (UTC)
Received: from napanee.usersys.redhat.com (dhcp-17-195.bos.redhat.com [10.18.17.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B14A8272AA;
        Mon,  6 Jan 2020 16:20:14 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id 4A58EC0C59; Mon,  6 Jan 2020 11:20:14 -0500 (EST)
Date:   Mon, 6 Jan 2020 11:20:14 -0500
From:   'Aristeu Rozanski' <aris@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "'linux-edac@vger.kernel.org'" <linux-edac@vger.kernel.org>,
        'Mauro Carvalho Chehab' <mchehab@kernel.org>
Subject: Re: [PATCH] EDAC: skx_common: downgrade message importance on
 missing PCI device
Message-ID: <20200106162013.cbbeo4ezdp2h7p62@redhat.com>
References: <20191204212325.c4k47p5hrnn3vpb5@redhat.com>
 <3908561D78D1C84285E8C5FCA982C28F7F4F13AB@ORSMSX115.amr.corp.intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7F4F19BD@ORSMSX115.amr.corp.intel.com>
 <20191210090013.GA9395@zn.tnic>
 <20200106151242.vkdiiwhubmkx5osh@redhat.com>
 <20200106161732.GF12238@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106161732.GF12238@zn.tnic>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jan 06, 2020 at 05:17:32PM +0100, Borislav Petkov wrote:
> On Mon, Jan 06, 2020 at 10:12:42AM -0500, 'Aristeu Rozanski' wrote:
> > The other option I can think about is just allowing the module to load
> > in this situation: the CPU is present but you have no memory controller
> > PCI devices present. Some drivers will allow loading without having a
> > device present without errors. It's not clean as having to come up with
> > something modutils can pick up as hint to not try to load more than once.
> 
> Yeah, but having a driver loaded when there's no hw to drive is also not
> pretty.
> 
> > Or could just downgrade this specific message since it's a very common
> > case and let the more unusual situations report more than once.
> 
> Yap, we did a similar thing for adm64_edac:
> 
> 7fdfee926be7 ("EDAC/amd64: Get rid of the ECC disabled long message")
> 
> but instead of downgrading prio we actually went and killed it directly.
> 
> :-)

OK, will resubmit this patch just removing the messages then.

Thanks!

-- 
Aristeu

