Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E622192BE
	for <lists+linux-edac@lfdr.de>; Wed,  8 Jul 2020 23:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgGHVqC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Wed, 8 Jul 2020 17:46:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:52224 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgGHVqC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 8 Jul 2020 17:46:02 -0400
IronPort-SDR: FUkXxY3mTm+mrZugqooGMVjxhgejEkOMhLeRCvrAQjOvtX8Q4btdo8cSY9KtrEvCFxIguEqK9V
 uUHKP2Rxik2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="127975855"
X-IronPort-AV: E=Sophos;i="5.75,329,1589266800"; 
   d="scan'208";a="127975855"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 14:46:01 -0700
IronPort-SDR: b3/Nl7o/5L5vZWeO8rnyzaiu8+4l5S+P1dJdDBbqdmILDrN2UJ/fzeAkbhvO6vcwQPgzy85Yq2
 iE6dCSt4qPqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,329,1589266800"; 
   d="scan'208";a="358227657"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga001.jf.intel.com with ESMTP; 08 Jul 2020 14:46:01 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.56]) by
 ORSMSX109.amr.corp.intel.com ([169.254.11.7]) with mapi id 14.03.0439.000;
 Wed, 8 Jul 2020 14:46:01 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC-I7300: Replace HTTP links with HTTPS ones
Thread-Topic: [PATCH] EDAC-I7300: Replace HTTP links with HTTPS ones
Thread-Index: AQHWVWie+YliV8zoVE+6QUbgzvKOq6j+Nl9Q
Date:   Wed, 8 Jul 2020 21:46:00 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F68E520@ORSMSX115.amr.corp.intel.com>
References: <20200708204425.22444-1-grandmaster@al2klimov.de>
In-Reply-To: <20200708204425.22444-1-grandmaster@al2klimov.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

  * Intel 7300 Chipset Memory Controller Hub (MCH) - Datasheet
- *	http://www.intel.com/Assets/PDF/datasheet/318082.pdf
+ *	https://www.intel.com/Assets/PDF/datasheet/318082.pdf

Sadly Intel isn't good at long term stable URLs for documentation
and both of those links are dead. :-(

FWIW the current URL for that is

https://www.intel.com/content/dam/doc/datasheet/7300-chipset-memory-controller-hub-datasheet.pdf

But who knows if it will still be good by the end of the week.

-Tony
