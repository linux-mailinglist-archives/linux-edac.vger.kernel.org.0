Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA55132A77
	for <lists+linux-edac@lfdr.de>; Tue,  7 Jan 2020 16:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbgAGPvQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 7 Jan 2020 10:51:16 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43854 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgAGPvQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 7 Jan 2020 10:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578412275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ilDKmkvq2bzVxJ0yNzxJPU0ulkPxpHWKkfzpD/P/FpU=;
        b=JQXzh1tthumArH3FhPVbs0zoPChnT50xPK8Uhl3UJktaST09zjGX32IK8QLTwBQdo+8QMf
        O7zxXuwtuyRJRmndTgvX3eRAyOfQlKC+XJRu9Snnu4rt/VJqUr4OjCng7ywbnGR+eT20I+
        CffZTwshuIF0k4qjfKPX04aw+wLD17Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-LybLpKTCP_qjoUzv4-ZHig-1; Tue, 07 Jan 2020 10:51:11 -0500
X-MC-Unique: LybLpKTCP_qjoUzv4-ZHig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88691805741;
        Tue,  7 Jan 2020 15:51:10 +0000 (UTC)
Received: from napanee.usersys.redhat.com (dhcp-17-195.bos.redhat.com [10.18.17.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6999D271A3;
        Tue,  7 Jan 2020 15:51:10 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id F1D7EC39AC; Tue,  7 Jan 2020 10:51:09 -0500 (EST)
Date:   Tue, 7 Jan 2020 10:51:09 -0500
From:   'Aristeu Rozanski' <aris@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "'linux-edac@vger.kernel.org'" <linux-edac@vger.kernel.org>,
        'Mauro Carvalho Chehab' <mchehab@kernel.org>
Subject: Re: [PATCH] EDAC: skx_common: downgrade message importance on
 missing PCI device
Message-ID: <20200107155109.6gphrtqb2a7q4unn@redhat.com>
References: <20191204212325.c4k47p5hrnn3vpb5@redhat.com>
 <3908561D78D1C84285E8C5FCA982C28F7F4F13AB@ORSMSX115.amr.corp.intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7F4F19BD@ORSMSX115.amr.corp.intel.com>
 <20191210090013.GA9395@zn.tnic>
 <20200106151242.vkdiiwhubmkx5osh@redhat.com>
 <20200106161732.GF12238@zn.tnic>
 <20200106162013.cbbeo4ezdp2h7p62@redhat.com>
 <20200106162306.GG12238@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106162306.GG12238@zn.tnic>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jan 06, 2020 at 05:23:06PM +0100, Borislav Petkov wrote:
> I'm not saying you should blindly remove them. They might be useful for
> debugging purposes so you should consider that usage angle first. In the
> AMD case, the message was really useless.

Ah, I thought you had an objection to this patch :)
Do you mind considering it for inclusion?

-- 
Aristeu

