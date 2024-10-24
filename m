Return-Path: <linux-edac+bounces-2259-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BE39AF43E
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 23:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3CF2825B4
	for <lists+linux-edac@lfdr.de>; Thu, 24 Oct 2024 21:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B46AE2010FA;
	Thu, 24 Oct 2024 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUjFANw5"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A49022B655;
	Thu, 24 Oct 2024 21:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804014; cv=none; b=jRBjEBCFPHy2KTMuMnYCnRFuLr3krHFhELuWNjdyrs3p77lhWEf7BmBOQ+yhqN8K/LGYJr5ifyKwGufA9hr3TNUujifExWVVjiVz5lnLoBPbOsZmVWbZXpn/dgKcxFJdHEHELLiLVEXRDBBFsEr3mXH2DBQFijPzhR8YlkKEEF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804014; c=relaxed/simple;
	bh=we3DHtDWPrqbGGchaUWaVxv0Vsx9gaO8PmM4pPDozE4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NQqCQ6KWTrfNBwo52PTZGUhMIuqHy97/HRpvcdT1R+0ufaygCDdYVQzrIkC6oVawvlyyCn02RjTJ0FTBh62qNgM7Ju/+harrmVgUHXwlPhbE5kIl9B0pVDJS3gLwYAeJR+tntcxdf2YwOxkSCTp72ZC6UsEgclTVTYoyOShxT3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUjFANw5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBED2C4CEC7;
	Thu, 24 Oct 2024 21:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729804014;
	bh=we3DHtDWPrqbGGchaUWaVxv0Vsx9gaO8PmM4pPDozE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GUjFANw564bwlcIadyrbicxHK5RXFTK19jkJFK+w3tHQ5HNQNqg2xJaA7rZjb+lA9
	 R/J6yI1iU/an4iEQ0z9S4t1cnI6WAWvBNwYaR88EN5G5mg/Zy0JqGPzJfCFfkPohTy
	 VIs42oBM4SHeh+gfbT8DuddK5RrvGlpadiPMFbjhJ2auzKfu+mAfJ5UD3aLaLo63fo
	 REK+Cy5NEhg3f6qsWC/eZmhoP39GNqBUveSOB5eWqVH0dqlOM4g/dc68wFzJj1wnTW
	 OCAIKR3CezLGvsi2vY3oEis2kLtWGNZX22eVqTSb2yarGZzlEhCPBXz57xed/4EzxD
	 QN4tLGfzPVWJw==
Date: Thu, 24 Oct 2024 16:06:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
	avadhut.naik@amd.com, john.allen@amd.com, bhelgaas@google.com,
	Shyam-sundar.S-k@amd.com, richard.gong@amd.com, jdelvare@suse.com,
	linux@roeck-us.net, clemens@ladisch.de, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, linux-pci@vger.kernel.org,
	linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	naveenkrishna.chatradhi@amd.com, carlos.bilbao.osdev@gmail.com
Subject: Re: [PATCH 00/16] AMD NB and SMN rework
Message-ID: <20241024210652.GA1003184@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79cb3a45-8f42-4ef8-9c21-acaae5fbbe04@amd.com>

On Thu, Oct 24, 2024 at 03:08:41PM -0500, Mario Limonciello wrote:
> On 10/24/2024 12:46, Bjorn Helgaas wrote:
> > On Thu, Oct 24, 2024 at 12:01:59PM -0400, Yazen Ghannam wrote:
> > > On Wed, Oct 23, 2024 at 12:59:28PM -0500, Bjorn Helgaas wrote:
> > > > On Wed, Oct 23, 2024 at 05:21:34PM +0000, Yazen Ghannam wrote:
> ...

> > > > The use of pci_get_slot() and pci_get_domain_bus_and_slot() is not
> > > > ideal since all those pci_get_*() interfaces are kind of ugly in my
> > > > opinion, and using them means we have to encode topology details in
> > > > the kernel.  But this still seems like a big improvement.
> > > 
> > > Thanks for the feedback. Hopefully, we'll come to some improved
> > > solution. :)
> > > 
> > > Can you please elaborate on your concern? Is it about saying "thing X is
> > > always at SBDF A:B:C.D" or something else?
> > 
> > "Thing X is always at SBDF A:B:C.D" is one big reason.  "A:B:C.D" says
> > nothing about the actual functionality of the device.  A PCI
> > Vendor/Device ID or a PNP ID identifies the device programming model
> > independent of its geographical location.  Inferring the functionality
> > and programming model from the location is a maintenance issue because
> > hardware may change the address.
> > 
> > PCI bus numbers are under software control, so in general it's not
> > safe to rely on them, although in this case these devices are probably
> > on root buses where the bus number is either fixed or determined by
> > BIOS configuration of the host bridge.
> > 
> > I don't like the pci_get_*() functions because they break the driver
> > model.  The usual .probe() model binds a device to a driver, which
> > essentially means the driver owns the device and its resources, and
> > the driver and doesn't have to worry about other code interfering.
> 
> Are you suggesting that perhaps we should be introducing amd_smn (patch 10)
> as a PCI driver that binds "to the root device" instead?

I don't know any of the specifics, so I can't really opine on that.

The PCI specs envision that a Vendor/Device ID defines the programming
model of the device, and you would only use a new Device ID when that
programming model changes.

Of course, vendors like to define a new set of Device IDs for every
new chipset even when no driver changes are required, so even if a new
SMN works exactly the same as in previous chipsets, you're probably
back to having to add a new Device ID for every new chipset.

The Subsystem Vendor ID and Subsystem ID exist to solve a similar
problem (sort of in reverse).  If AMD could allocate a Subsystem ID
for this SMN programming model and use that same ID in every chipset,
you could make a pci_driver.id_table entry that would match them all,
e.g.,

  .vendor = PCI_VENDOR_ID_AMD,
  .device = PCI_ANY_ID,
  .subvendor = PCI_VENDOR_ID_AMD,
  .subdevice = PCI_SUBSYSTEM_AMD_SMN,

(pci_device_id.subdevice is misnamed; the spec calls it "Subsystem ID")

> There are some areas that do discovery (for example amd_node_get_root() in
> patch 6/16).

Sort of.  amd_node_get_root() and amd_node_get_func() both just grub
through all the devices that the PCI core has enumerated and return
the one that has the right geographical address.

There's no binding to a driver, so another driver could come along and
bind to the same device, and then you have a potential conflict.

You also give up all the standard driver model infrastructure for
hotplug, power management, etc.  Granted, you probably don't care
about those things here.

Bjorn

