Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029973E5610
	for <lists+linux-edac@lfdr.de>; Tue, 10 Aug 2021 10:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbhHJI5R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Tue, 10 Aug 2021 04:57:17 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:49719 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238379AbhHJI5Q (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Aug 2021 04:57:16 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-234-w1_GZZkGMW-hVo-Y0c_N0g-1; Tue, 10 Aug 2021 09:56:52 +0100
X-MC-Unique: w1_GZZkGMW-hVo-Y0c_N0g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Tue, 10 Aug 2021 09:56:52 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Tue, 10 Aug 2021 09:56:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>, Robert Richter <rric@kernel.org>,
        "Len Baker" <len.baker@gmx.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] drivers/edac/edac_mc: Remove all strcpy() uses
Thread-Topic: [PATCH v3] drivers/edac/edac_mc: Remove all strcpy() uses
Thread-Index: AQHXjUKovGKiu304s0CSrAMXVBAc3KtsbpXQ
Date:   Tue, 10 Aug 2021 08:56:51 +0000
Message-ID: <c24330a3d7464ed3951d513bb1559258@AcuMS.aculab.com>
References: <20210807155957.10069-1-len.baker@gmx.com>
         <ff02ffffdc130a772c01ec0edbf8d1e684b0730a.camel@perches.com>
         <20210808112617.GA1927@titan> <YRD90L6PMoVbbv+9@rric.localdomain>
 <99448ef29830fda9b19409bc23b0e7513b22f7b7.camel@perches.com>
In-Reply-To: <99448ef29830fda9b19409bc23b0e7513b22f7b7.camel@perches.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Joe Perches
> Sent: 09 August 2021 18:19
> 
> On Mon, 2021-08-09 at 12:05 +0200, Robert Richter wrote:
> > On 08.08.21 13:26:17, Len Baker wrote:
> >
> > > > Perhaps this should use scnprintf rather than strscpy
> > > > Something like:
> > > > 			n += scnprintf(buf + n, len - n, "%s",
> > > > 				       p == e->label ? dim->label : OTHER_LABEL);
> > > >
> > > In the first version [1] the scnprintf was used but Robert Richter don't
> > > see any benefit compared with the current implementation.
> > >
> > > [1] https://lore.kernel.org/linux-hardening/20210725162954.9861-1-len.baker@gmx.com/
> >
> > Reason is that there is the assumption that p must always point at the
> > end of the string and its trailing zero byte. I am not opposed using
> > the string function's return code instead of strlen() to get the
> > length. But why using formated output if strscpy() can be used?
> 
> strscpy and scnprintf have different return values and it's simpler
> and much more common to use scnprintf for appended strings that are
> limited to a specific buffer length.

scnprintf() will be a lot slower, but has a much better return value
than most of the strxxxcpy() functions.

The only slight problem is that you can't differentiate overflow
from a max-length output.

Trouble is fixing that adds 'yet another set of functions'.
Clearly we need the yellow with purple stripe ones :-)
Probably:
	offset = xxx(buf, len, offset, ......)
where offset == len on truncation.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

