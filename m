Return-Path: <linux-edac+bounces-5168-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DF4C02761
	for <lists+linux-edac@lfdr.de>; Thu, 23 Oct 2025 18:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43FCB3A32B3
	for <lists+linux-edac@lfdr.de>; Thu, 23 Oct 2025 16:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C9330BF64;
	Thu, 23 Oct 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPOj2ISn"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C345926ED3A
	for <linux-edac@vger.kernel.org>; Thu, 23 Oct 2025 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761237126; cv=none; b=Ad7SyE57YYmcI4EmWoawMME9LRqWDKoN/7FfVVohiakR5Q0Cj4ZHsK3oOdYD4JrSQK/04MkRzuJJOyirQNADqvt290hti8R51fYOz9tO6vwSi1M0OkgNh9WGVFNwQnDKcNyiQa52Lym6Fxvj0w0i22pYRabsyO4iBdbxs0xYmDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761237126; c=relaxed/simple;
	bh=78weOO8Ux2KH5nxBXBMycmrZ0njLHapCj22wQXG6s3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bc8WmOvBI1u5dCsqRr/VvdzF1T86wgO92zR9TgjNaLoQecmb7WLmzAfMswKbLEvW5yXIs5vykK6IxeJEYAzbsjYeX+w2TP1ykiQZ8t/HvqkwjEEtUwnZAwngSDZISxC1sb0n92LOibcAZfeteB7hovIVAF8M3zFCr43GcXtH4eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPOj2ISn; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso3370251e87.1
        for <linux-edac@vger.kernel.org>; Thu, 23 Oct 2025 09:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761237123; x=1761841923; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YYfGw1tMl9yOFknFdOBqe6dPAFpDn53Uc6QGIFFot64=;
        b=CPOj2ISnBOnl4iCLFjfOJucUjxSETQ6CbG9YSwqBFSEtUTBKLWXy1+l5lRnxaCN+vH
         5uAUmszSCO+dvRy/VltRs7a5vL4NA9TH53ib6KPH/mIZRTptY/FlisIt9/uLWoaZpoqz
         361PvGn55/JcW0isPzu7mKYsQkRjhJLoiO9MWai5bCUA29N3QOxNidyWB+WL2SvM1q0L
         joWZijH0p0d6BdXVHP6/tp/LUxDExuctyAjCAzQ3Yoqeb8rBtix6+bYdI3KpjsQIE6r3
         ek/c48hGWOxpMbmGsZUKtVPm/xdT9PE+bto7m926fVmtZjrpul23esgn5BJ5rHgRqIkL
         0gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761237123; x=1761841923;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYfGw1tMl9yOFknFdOBqe6dPAFpDn53Uc6QGIFFot64=;
        b=WQZO063VpMYsHDOamiQUh1+fya7+9F6kpIR707vGh1a21jcNrrPDKtF0wk9sd/SKmO
         oS7PzSewiNONt8u3kYLfzcHRd7mvacwVCtreFbtlT/esuQy5eyrXNIonT4Jmge1r/CxT
         2ALT0qX3MDK4HhSvsJ9WJkmYyQOKqndSShI2bn42KGMX8Q5uh7tvsytuNAedu2VQ92YK
         X2H00Pvkcb1XfjD8AGPMMR+k6z6h7Oe23Vp9uH/CUGgzcMch5rb4kTJ0FZsiVoruwDlG
         tMOMjvWKnR1Q+Y1qIER4/fHxAthIPysnHqdeWyDN79x6UYPT5sj5c0rKj6h0oUaZSsxR
         U5IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHL+3RIyuy2VjaRVY7YptyesQZUUojSnuRgTwWC8Gyq7m0tOlbMI5n+BhhbxvFHmVcNqMoZOOpQSTa@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5e2cKDn+F4BhK0HcqoRcuQT+x1v6jh9kHiVX2euX7JMdjXRf7
	PstQ9ZLTAKIUtGWx0qCuZibX1I0E90+EpkXwaZlfmSAkxjqYGOqV+Z1g
X-Gm-Gg: ASbGncvbiElXQj8mN6Y3G+7RtfCcB3pQzA86G5srV0CRSYyhUjBWRJ7+HLmtoGKBx6L
	HQL8XZRkk0HnvkKWHXxFetVRYWG/tTo/d1utMpQtE+XHGC4IrqW3K+9FywDG9LSAzaXzdoj+P8t
	LWyyjaRpRVqCDrVV/j6T4a1H6DOYi3YUP41sfZ8UA8ptfr3C8vaZS+KVFe59/37AquyXfF9joWO
	h8PjJ45x+4sB9kBQjyLj4yq66R4zBUJKNziM3JO0nXGQRq/qh7uKGcuR5DJFk3T34wCdBzCRu+O
	GmQJG31XMoa7Dig6YDr1wR+fBfQuEstK/ZGKMuy9c7vlVaqaMNLlezysLYLeqvz79OomQajc7EX
	5FJ1d3dyFkUuiGkHJrDS0XHNUXtEgm2eR+lMMc6SOMdu8rJrwFijubv2PzhWJirnxTJ5v9NYRun
	cM4Y53rQlpUTMZk92P
X-Google-Smtp-Source: AGHT+IFKo/4nyXPNKUqA7IAS5KBLXbS3dKQTgE6kBFLo6yQ7yPWiD+r65VS0c92Ld+0Cdijp698faQ==
X-Received: by 2002:a05:6512:12c4:b0:57a:8eb7:1ea2 with SMTP id 2adb3069b0e04-592dc07e150mr2493948e87.27.1761237122517;
        Thu, 23 Oct 2025 09:32:02 -0700 (PDT)
Received: from foxbook (bey128.neoplus.adsl.tpnet.pl. [83.28.36.128])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-592f4d2d367sm828133e87.103.2025.10.23.09.32.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Oct 2025 09:32:01 -0700 (PDT)
Date: Thu, 23 Oct 2025 18:31:54 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Shyam-sundar.S-k@amd.com, bhelgaas@google.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
 linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux@roeck-us.net, mario.limonciello@amd.com,
 naveenkrishna.chatradhi@amd.com, platform-driver-x86@vger.kernel.org,
 suma.hegde@amd.com, tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH v3 06/12] x86/amd_nb: Use topology info to get AMD node
 count
Message-ID: <20251023183154.1e807af6.michal.pecio@gmail.com>
In-Reply-To: <20251023160906.GA730672@yaz-khff2.amd.com>
References: <20250107222847.3300430-7-yazen.ghannam@amd.com>
	<20251022011610.60d0ba6e.michal.pecio@gmail.com>
	<20251022133901.GB7243@yaz-khff2.amd.com>
	<20251022173831.671843f4.michal.pecio@gmail.com>
	<20251022160904.GA174761@yaz-khff2.amd.com>
	<20251022181856.0e3cfc92.michal.pecio@gmail.com>
	<20251023135935.GA619807@yaz-khff2.amd.com>
	<20251023170107.0cc70bad.michal.pecio@gmail.com>
	<20251023160906.GA730672@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/L/dcs+e8mHMeXY=3blTIATs"

--MP_/L/dcs+e8mHMeXY=3blTIATs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 23 Oct 2025 12:09:06 -0400, Yazen Ghannam wrote:
> On Thu, Oct 23, 2025 at 05:01:07PM +0200, Michal Pecio wrote:
> > On Thu, 23 Oct 2025 09:59:35 -0400, Yazen Ghannam wrote:  
> > > Thanks Michal.
> > > 
> > > I don't see anything obviously wrong.  
> > 
> > Which code is responsible for setting up those bitmaps which
> > are counted by topology_init_possible_cpus()?
> > 
> > I guess I could add some printks there and reboot.
> >   
> 
> The kernel seems to think there are 6 CPUs on your system:
> 
> [    0.072059] CPU topo: Allowing 4 present CPUs plus 2 hotplug CPUs

I thought this is because I have NR_CPUS set to 6, as this config
originally came from the X6 machine, but I am not sure.

> 
> We don't seem them enabled, but they may still get APIC IDs. If so, then
> the IDs would be beyond the core shift of 2.
> 
> APIC IDs b'0 00 -> CPU0 on logical package 0
> 	 b'0 01 -> CPU1 on logical package 0
> 	 b'0 10 -> CPU2 on logical package 0
> 	 b'0 11 -> CPU3 on logical package 0
> 	 b'1 00 -> CPU0 on logical package 1
> 	 b'1 01 -> CPU1 on logical package 1
> 
> 
> Please try booting with "possible_cpus=4".

OK, will try it next time I'm rebooting.

> The "number of possible CPUs" comes from the ACPI Multiple APIC
> Description Table (MADT). This has the signature "APIC".
> 
> Can you please provide the disassembly of this table?

Interesting, it looks like there are indeed 6 LAPICs there.
BIOS bug? Attaching apic.dsl.

> Can you please share the dmesg output from that system? And the ACPI
> table too?

Will try later but I don't recall any anomalies there.
I remember checking the topology output and it made sense:
1 package, 1 die, 6 cores, 6 threads.

--MP_/L/dcs+e8mHMeXY=3blTIATs
Content-Type: text/x-dsl
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=apic.dsl

/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20211217 (64-bit version)
 * Copyright (c) 2000 - 2021 Intel Corporation
 * 
 * Disassembly of apic.dat, Thu Oct 23 18:19:16 2025
 *
 * ACPI Data Table [APIC]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
 */

[000h 0000   4]                    Signature : "APIC"    [Multiple APIC Description Table (MADT)]
[004h 0004   4]                 Table Length : 0000007C
[008h 0008   1]                     Revision : 01
[009h 0009   1]                     Checksum : F5
[00Ah 0010   6]                       Oem ID : "080912"
[010h 0016   8]                 Oem Table ID : "APIC1703"
[018h 0024   4]                 Oem Revision : 20120809
[01Ch 0028   4]              Asl Compiler ID : "MSFT"
[020h 0032   4]        Asl Compiler Revision : 00000097

[024h 0036   4]           Local Apic Address : FEE00000
[028h 0040   4]        Flags (decoded below) : 00000001
                         PC-AT Compatibility : 1

[02Ch 0044   1]                Subtable Type : 00 [Processor Local APIC]
[02Dh 0045   1]                       Length : 08
[02Eh 0046   1]                 Processor ID : 01
[02Fh 0047   1]                Local Apic ID : 00
[030h 0048   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[034h 0052   1]                Subtable Type : 00 [Processor Local APIC]
[035h 0053   1]                       Length : 08
[036h 0054   1]                 Processor ID : 02
[037h 0055   1]                Local Apic ID : 01
[038h 0056   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[03Ch 0060   1]                Subtable Type : 00 [Processor Local APIC]
[03Dh 0061   1]                       Length : 08
[03Eh 0062   1]                 Processor ID : 03
[03Fh 0063   1]                Local Apic ID : 02
[040h 0064   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[044h 0068   1]                Subtable Type : 00 [Processor Local APIC]
[045h 0069   1]                       Length : 08
[046h 0070   1]                 Processor ID : 04
[047h 0071   1]                Local Apic ID : 03
[048h 0072   4]        Flags (decoded below) : 00000001
                           Processor Enabled : 1
                      Runtime Online Capable : 0

[04Ch 0076   1]                Subtable Type : 00 [Processor Local APIC]
[04Dh 0077   1]                       Length : 08
[04Eh 0078   1]                 Processor ID : 05
[04Fh 0079   1]                Local Apic ID : 84
[050h 0080   4]        Flags (decoded below) : 00000000
                           Processor Enabled : 0
                      Runtime Online Capable : 0

[054h 0084   1]                Subtable Type : 00 [Processor Local APIC]
[055h 0085   1]                       Length : 08
[056h 0086   1]                 Processor ID : 06
[057h 0087   1]                Local Apic ID : 85
[058h 0088   4]        Flags (decoded below) : 00000000
                           Processor Enabled : 0
                      Runtime Online Capable : 0

[05Ch 0092   1]                Subtable Type : 01 [I/O APIC]
[05Dh 0093   1]                       Length : 0C
[05Eh 0094   1]                  I/O Apic ID : 04
[05Fh 0095   1]                     Reserved : 00
[060h 0096   4]                      Address : FEC00000
[064h 0100   4]                    Interrupt : 00000000

[068h 0104   1]                Subtable Type : 02 [Interrupt Source Override]
[069h 0105   1]                       Length : 0A
[06Ah 0106   1]                          Bus : 00
[06Bh 0107   1]                       Source : 00
[06Ch 0108   4]                    Interrupt : 00000002
[070h 0112   2]        Flags (decoded below) : 0000
                                    Polarity : 0
                                Trigger Mode : 0

[072h 0114   1]                Subtable Type : 02 [Interrupt Source Override]
[073h 0115   1]                       Length : 0A
[074h 0116   1]                          Bus : 00
[075h 0117   1]                       Source : 09
[076h 0118   4]                    Interrupt : 00000009
[07Ah 0122   2]        Flags (decoded below) : 000F
                                    Polarity : 3
                                Trigger Mode : 3

Raw Table Data: Length 124 (0x7C)

    0000: 41 50 49 43 7C 00 00 00 01 F5 30 38 30 39 31 32  // APIC|.....080912
    0010: 41 50 49 43 31 37 30 33 09 08 12 20 4D 53 46 54  // APIC1703... MSFT
    0020: 97 00 00 00 00 00 E0 FE 01 00 00 00 00 08 01 00  // ................
    0030: 01 00 00 00 00 08 02 01 01 00 00 00 00 08 03 02  // ................
    0040: 01 00 00 00 00 08 04 03 01 00 00 00 00 08 05 84  // ................
    0050: 00 00 00 00 00 08 06 85 00 00 00 00 01 0C 04 00  // ................
    0060: 00 00 C0 FE 00 00 00 00 02 0A 00 00 02 00 00 00  // ................
    0070: 00 00 02 0A 00 09 09 00 00 00 0F 00              // ............

--MP_/L/dcs+e8mHMeXY=3blTIATs--

