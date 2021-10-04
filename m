Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD994212B2
	for <lists+linux-edac@lfdr.de>; Mon,  4 Oct 2021 17:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbhJDPcy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Mon, 4 Oct 2021 11:32:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:44485 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234917AbhJDPcy (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 4 Oct 2021 11:32:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="311679231"
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="311679231"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 08:21:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="483157815"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga007.fm.intel.com with ESMTP; 04 Oct 2021 08:21:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 4 Oct 2021 08:21:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 4 Oct 2021 08:21:14 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.012;
 Mon, 4 Oct 2021 08:21:14 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Eric Badger <ebadger@purestorage.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        "open list:EDAC-CORE" <linux-edac@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC/mc_sysfs: Print MC-scope sysfs counters unsigned
Thread-Topic: [PATCH] EDAC/mc_sysfs: Print MC-scope sysfs counters unsigned
Thread-Index: AQHXuILh17+pdjiyHUKscEUknTnYO6vC9PPQ
Date:   Mon, 4 Oct 2021 15:21:13 +0000
Message-ID: <045ce9cf33904a52a365a04c055c5cbf@intel.com>
References: <20211003181653.GA685515@ebadger-ThinkPad-T590>
In-Reply-To: <20211003181653.GA685515@ebadger-ThinkPad-T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> This is cosmetically nicer for counts > INT32_MAX, and aligns the
> MC-scope format with that of the lower layer sysfs counter files.

While this is technically the right thing to do, I pity the system administrator that
is looking at a system with more than 2147483647 corrected or uncorrected errors!

So:

Acked-by: Tony Luck <tony.luck@intel.com>

but maybe this is just churn and not really useful in practice?

-Tony
