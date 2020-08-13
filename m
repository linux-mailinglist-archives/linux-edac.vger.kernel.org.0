Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45BAC243B5F
	for <lists+linux-edac@lfdr.de>; Thu, 13 Aug 2020 16:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgHMORR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Aug 2020 10:17:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25419 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726082AbgHMORQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 13 Aug 2020 10:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597328235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3f9839A39kS2T1B0Nl2pfa9tOtustXpnjtZaLs9U50o=;
        b=Vpj1ukhAzwJfdbf6y2PQrdsSfjOl4Noyeua8ahLZybYJS+NhM36jw/zMwhxc3Sh2d3ltRB
        PJ41KJya+4Bz3X72LXuUydqMXfrLO+wxboxWcKtNeqjuJfQqZErGTGgno5FfZV3A2aL1jE
        OjIyG4ONQ8DO3bvhLAN+NgA4UGQ8rao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-3-YxccykMRip2ut5x4Ay2g-1; Thu, 13 Aug 2020 10:17:12 -0400
X-MC-Unique: 3-YxccykMRip2ut5x4Ay2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0827D8B5DFF;
        Thu, 13 Aug 2020 14:17:11 +0000 (UTC)
Received: from napanee.usersys.redhat.com (dhcp-17-195.bos.redhat.com [10.18.17.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1E9A5D990;
        Thu, 13 Aug 2020 14:17:10 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id 63F06C1C51; Thu, 13 Aug 2020 10:17:10 -0400 (EDT)
Date:   Thu, 13 Aug 2020 10:17:10 -0400
From:   Aristeu Rozanski <aris@redhat.com>
To:     Boris Petkov <bp@alien8.de>
Cc:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] EDAC/ie31200: fallback if host bridge device is already
 initialized
Message-ID: <20200813141710.ug5ei4hxoorproi4@redhat.com>
References: <1594923911-10885-1-git-send-email-jbaron@akamai.com>
 <20200813134406.23dvvsulfxend5jx@redhat.com>
 <FE8145F7-A6A9-446F-A13F-3A14CF6E1934@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FE8145F7-A6A9-446F-A13F-3A14CF6E1934@alien8.de>
User-Agent: NeoMutt/20200501
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 13, 2020 at 04:55:50PM +0300, Boris Petkov wrote:
> On August 13, 2020 4:44:06 PM GMT+03:00, Aristeu Rozanski <aris@redhat.com> wrote:
> >We tested this inside in machines having this issue and it works.
> >Patch looks good to me.
> >
> >Acked-by: Aristeu Rozanski <aris@redhat.com>
> 
> So Tested-by: you ?

Not by me, "we" meant as in company.

Tested-by: Vishal Agrawal <vagrawal@redhat.com>

-- 
Aristeu

