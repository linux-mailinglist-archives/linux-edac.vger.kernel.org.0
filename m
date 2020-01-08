Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7C9E134567
	for <lists+linux-edac@lfdr.de>; Wed,  8 Jan 2020 15:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgAHOyo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 Jan 2020 09:54:44 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52859 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727164AbgAHOyn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 8 Jan 2020 09:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578495282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dmJyQ8JJz+t+O7yXBHNdTEa+6XpWF9ogpZhb8x8wLk0=;
        b=c8Nc/r+tMOPfkzgfh0m0dE3wjBTTPqvuHO6II9PBYJkCJaz5wMq2OM2cwAQs/ir1vwFxsd
        V7HdMlLChL5GP2Mqs59m6JcJsGpFh3MST5O1hv4his4dcTp4BvdKdTwHSzp0Yc2wULBH4l
        mrh/uVarZ4GeGZY7jiBeMNbOdRyPd3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-N2WMkb3ZNluE7y1Am3XhLw-1; Wed, 08 Jan 2020 09:54:39 -0500
X-MC-Unique: N2WMkb3ZNluE7y1Am3XhLw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90E7ADB23;
        Wed,  8 Jan 2020 14:54:37 +0000 (UTC)
Received: from napanee.usersys.redhat.com (dhcp-17-195.bos.redhat.com [10.18.17.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68E8060FC6;
        Wed,  8 Jan 2020 14:54:37 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id C8EE1C0C0B; Wed,  8 Jan 2020 09:54:36 -0500 (EST)
Date:   Wed, 8 Jan 2020 09:54:36 -0500
From:   'Aristeu Rozanski' <aris@redhat.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "'linux-edac@vger.kernel.org'" <linux-edac@vger.kernel.org>,
        'Mauro Carvalho Chehab' <mchehab@kernel.org>
Subject: Re: [PATCH] EDAC: skx_common: downgrade message importance on
 missing PCI device
Message-ID: <20200108145436.7b77vuozxz2i5gll@redhat.com>
References: <3908561D78D1C84285E8C5FCA982C28F7F4F13AB@ORSMSX115.amr.corp.intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7F4F19BD@ORSMSX115.amr.corp.intel.com>
 <20191210090013.GA9395@zn.tnic>
 <20200106151242.vkdiiwhubmkx5osh@redhat.com>
 <20200106161732.GF12238@zn.tnic>
 <20200106162013.cbbeo4ezdp2h7p62@redhat.com>
 <20200106162306.GG12238@zn.tnic>
 <20200107155109.6gphrtqb2a7q4unn@redhat.com>
 <20200107164528.GD29542@zn.tnic>
 <20200107214310.GA31851@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107214310.GA31851@agluck-desk2.amr.corp.intel.com>
User-Agent: NeoMutt/20191207
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 07, 2020 at 01:43:10PM -0800, Luck, Tony wrote:
> Already applied to git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
> in edac-for-next branch.  Sorry, should have sent you an "Applied" message.

Thanks Tony.

-- 
Aristeu

