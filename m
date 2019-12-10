Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD83118AA4
	for <lists+linux-edac@lfdr.de>; Tue, 10 Dec 2019 15:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfLJOSd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Dec 2019 09:18:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52844 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727333AbfLJOSc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Dec 2019 09:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575987510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1V9JAqgeTVs6AxLBxEGbTRQLdHmJlItdgr4E2/Kbzj4=;
        b=VsrRdojRuL/fq+EeSCLQhzUlVLBa44IBlxDj+uRhmS/UByZhyYXUP2U0KhMi9pIiy+b+sx
        D8bMziwJHFmnF1gGBwZ1IvCrR0ka4Pr2PtwnnfQUQxyH9ktc0RhQer29zVZoaifTsAtekk
        bl0OMTcQI3TGgefytaB8gYtN0tIe5vg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-gLsvZp5IN7-CNwVLF1z3LA-1; Tue, 10 Dec 2019 09:18:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D353B1005512;
        Tue, 10 Dec 2019 14:18:25 +0000 (UTC)
Received: from napanee.usersys.redhat.com (dhcp-17-195.bos.redhat.com [10.18.17.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B403D5DA2C;
        Tue, 10 Dec 2019 14:18:25 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id 4B89FC0CE4; Tue, 10 Dec 2019 09:18:25 -0500 (EST)
Date:   Tue, 10 Dec 2019 09:18:25 -0500
From:   'Aristeu Rozanski' <aris@redhat.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "'linux-edac@vger.kernel.org'" <linux-edac@vger.kernel.org>,
        'Borislav Petkov' <bp@alien8.de>,
        'Mauro Carvalho Chehab' <mchehab@kernel.org>
Subject: Re: [PATCH] EDAC: skx_common: downgrade message importance on
 missing PCI device
Message-ID: <20191210141824.igfhvneacovuairi@redhat.com>
References: <20191204212325.c4k47p5hrnn3vpb5@redhat.com>
 <3908561D78D1C84285E8C5FCA982C28F7F4F13AB@ORSMSX115.amr.corp.intel.com>
 <3908561D78D1C84285E8C5FCA982C28F7F4F19BD@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F4F19BD@ORSMSX115.amr.corp.intel.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: gLsvZp5IN7-CNwVLF1z3LA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 10, 2019 at 12:02:45AM +0000, Luck, Tony wrote:
> > This looks like we call skx_init() once per core. Do we keep calling it=
 because
> > the calls are failing?  Or do we do that even when calls succeed?
> >
> > I was only really expecting that skx_init() would be called once.
>=20
> So (by experimentation) it seems that if the module load fails it
> will be retried num_online_cpus times (though not bound to each
> CPU in turn ... it will maybe try the init call on the same CPU multiple
> times, but miss running on some CPUs).
>=20
> If the load succeeds, then whoever is repeating the load decides
> to stop.

Or silently fails to load the module again for all online cpus.

--=20
Aristeu

